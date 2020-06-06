//
//  Engine.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

class Engine {
    
    enum Status {
        case running
        case paused
    }
    
    private let synapse2: Synapse2Updater
    private let synapse3: Synapse3Updater
    
    private var timer: Timer? = nil
    
    private(set) var status: Status
    
    init(synapse2: Synapse2Updater = Synapse2Updater(),
         synapse3: Synapse3Updater = Synapse3Updater()) {
        
        self.synapse2 = synapse2
        self.synapse3 = synapse3
        
        self.status = .paused
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

extension Engine: ObservableObject {}
