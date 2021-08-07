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

/// Responsible for the control of the FruityUI engine.

protocol Controlling {
    
    var status: ControllerStatus { get }
    
    func forceUpdate()
    func startUpdates()
    func pauseUpdates(withPauseType pauseType: PauseType)
}

/// Default implementation for Controlling.

class Controller: Controlling {
    
    private let synapse2: DeviceControlling
    private let synapse3: DeviceControlling
    
    private(set) var status: ControllerStatus
    
    private var usbWatcher: USBWatcher
    
    private var updating: Bool = false
    
    init(synapse2: Synapse2Controller = Synapse2Controller(),
         synapse3: Synapse3Controller = Synapse3Controller()) {
        
        self.synapse2 = synapse2
        self.synapse3 = synapse3
        
        self.status = .paused(.none)
        
        self.usbWatcher = USBWatcher()
        
        self.usbWatcher.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedDidWakeNotification),
                                               name: NSWorkspace.didWakeNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(forceUpdate),
                                               name: .persistentStoreRemoteChangeNotification,
                                               object: nil)
    }
    
    @objc private func receivedDidWakeNotification() {
        updating = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.updating = false
            
            self.forceUpdate()
        }
    }
    
    @objc func forceUpdate() {
        guard !updating else { return }
        
        updating = true
        
        var remaining = 2
        
        let completionBlockSemaphore = DispatchSemaphore(value: 1)
        
        let completionBlock: DeviceControlling.CompletionBlock = {
            completionBlockSemaphore.wait()
            
            defer {
                completionBlockSemaphore.signal()
            }
            
            remaining -= 1
            
            if remaining == 0 {
                self.updating = false
            }
        }
        
        if status == .running {
            synapse2.updateWithSavedConfigurations(completion: completionBlock)
            synapse3.updateWithSavedConfigurations(completion: completionBlock)
        } else if case let ControllerStatus.paused(pauseType) = status, pauseType == .lightsOut {
            synapse2.pause(with: pauseType, completion: completionBlock)
            synapse3.pause(with: pauseType, completion: completionBlock)
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
