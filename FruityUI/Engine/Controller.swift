//
//  Controller.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit

enum ControllerStatus: Equatable {
    
    case running
    case paused(PauseType)
}

protocol Controlling {
    
    var status: ControllerStatus { get }
    
    func forceUpdate()
    func startUpdates()
    func pauseUpdates(withPauseType pauseType: PauseType)
}

class Controller: Controlling {
    
    private let synapse2: DeviceControlling
    private let synapse3: DeviceControlling
    
    private(set) var status: ControllerStatus
    
    private var usbWatcher: USBWatcher
    
    init(synapse2: Synapse2Controller = Synapse2Controller(),
         synapse3: Synapse3Controller = Synapse3Controller()) {
        
        self.synapse2 = synapse2
        self.synapse3 = synapse3
        
        self.status = .paused(.none)
        
        self.usbWatcher = USBWatcher()
        
        self.usbWatcher.delegate = self
        
        NSWorkspace.shared.notificationCenter.addObserver(self,
                                                          selector: #selector(receivedDidWakeNotification),
                                                          name: NSWorkspace.didWakeNotification,
                                                          object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(forceUpdate),
                                               name: NSNotification.Name(rawValue: "NSPersistentStoreRemoteChangeNotification"),
                                               object: nil)
    }
    
    @objc private func receivedDidWakeNotification() {
        //  Just listening for the USB notifications would be enough in
        //  most cases, but by experience this doesn't always work,
        //  so this delayed update is a nice-to-have fallback.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.forceUpdate()
        }
    }
    
    @objc func forceUpdate() {
        if status == .running {
            synapse2.updateWithSavedConfigurations()
            synapse3.updateWithSavedConfigurations()
        } else if case let ControllerStatus.paused(pauseType) = status, pauseType == .lightsOut {
            synapse2.pause(with: pauseType)
            synapse3.pause(with: pauseType)
        }
    }
    
    func startUpdates() {
        status = .running
        
        forceUpdate()
    }
    
    func pauseUpdates(withPauseType pauseType: PauseType) {
        status = .paused(pauseType)
        
        forceUpdate()
    }
}

extension Controller: ObservableObject {}

extension Controller: USBWatcherDelegate {
    
    func deviceAdded(_ device: io_object_t) {
        guard let name = device.name(), String(name.prefix(5)) == "Razer" else {
            return
        }
        
        forceUpdate()
    }
    
    func deviceRemoved(_ device: io_object_t) {
        //  Ignored, this doesn't interest us for now.
    }
}
