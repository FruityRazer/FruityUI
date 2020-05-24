//
//  Engine.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

class Engine {
    
    private let synapse2: Synapse2Updater
    private let synapse3: Synapse3Updater
    
    private var timer: Timer? = nil
    
    init(synapse2: Synapse2Updater = Synapse2Updater(), synapse3: Synapse3Updater = Synapse3Updater()) {
        self.synapse2 = synapse2
        self.synapse3 = synapse3
    }
    
    func startUpdating(withInterval interval: TimeInterval = 10.0) {
        if let t = timer {
            t.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        
    }
    
    func pauseUpdates(with pauseType: PauseType) {
        if let t = timer {
            t.invalidate()
        }
        
        synapse2.pause(with: pauseType)
        synapse3.pause(with: pauseType)
    }
    
    @objc private func update() {
        synapse2.updateWithSavedConfigurations()
        synapse3.updateWithSavedConfigurations()
    }
}
