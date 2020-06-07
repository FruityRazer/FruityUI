//
//  Controller.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit

enum ControllerStatus {
    
    case running
    case paused
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
        
        self.status = .paused
        
        self.usbWatcher = USBWatcher()
        
        self.usbWatcher.delegate = self
        
        NSWorkspace.shared.notificationCenter.addObserver(self,
                                                          selector: #selector(receivedDidWakeNotification),
                                                          name: NSWorkspace.didWakeNotification,
                                                          object: nil)
    }
    
    @objc private func receivedDidWakeNotification() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.forceUpdate()
        }
    }
    
    func forceUpdate() {
        if status == .running {
            synapse2.updateWithSavedConfigurations()
            synapse3.updateWithSavedConfigurations()
        }
    }
    
    func startUpdates() {
        status = .running
        
        synapse2.updateWithSavedConfigurations()
    }
    
    func pauseUpdates(withPauseType pauseType: PauseType) {
        synapse2.pause(with: pauseType)
        synapse3.pause(with: pauseType)
    }
    
    @objc private func update() {
        synapse3.updateWithSavedConfigurations()
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
