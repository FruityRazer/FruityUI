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
    
    func manualUpdate()
    func startUpdating(withInterval interval: TimeInterval)
    func pauseUpdates(withPauseType pauseType: PauseType)
}

extension Controlling {
    
    func startUpdating() {
        self.startUpdating(withInterval: 10.0)
    }
}

class Controller: Controlling {
    
    private let synapse2: DeviceControlling
    private let synapse3: DeviceControlling
    
    private var timer: Timer? = nil
    
    private(set) var status: ControllerStatus
    
    private var usbWatcher: USBWatcher
    
    init(synapse2: Synapse2Controller = Synapse2Controller(),
         synapse3: Synapse2Controller = Synapse2Controller()) {
        
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
            self.manualUpdate()
        }
    }
    
    func manualUpdate() {
        if status == .running {
            synapse2.updateWithSavedConfigurations()
            synapse3.updateWithSavedConfigurations()
        }
    }
    
    func startUpdating(withInterval interval: TimeInterval = 10.0) {
        if let t = timer {
            t.invalidate()
        }
        
        status = .running
        
        synapse2.updateWithSavedConfigurations()
        
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(update),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func pauseUpdates(withPauseType pauseType: PauseType) {
        if let t = timer {
            t.invalidate()
        }
        
        status = .paused
        
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
        
        manualUpdate()
    }
    
    func deviceRemoved(_ device: io_object_t) {
        //  Ignored, this doesn't interest us for now.
    }
}
