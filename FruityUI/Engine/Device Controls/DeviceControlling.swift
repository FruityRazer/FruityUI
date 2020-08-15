//
//  Updater.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 24/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

enum PauseType: Equatable {
    
    case lightsOut
    case none
}

protocol DeviceControlling {
    
    typealias CompletionBlock = () -> ()
    
    func updateWithSavedConfigurations(completion: CompletionBlock?)
    func pause(with: PauseType, completion: CompletionBlock?)
}

extension DeviceControlling {
    
    func updateWithSavedConfigurations() {
        updateWithSavedConfigurations(completion: nil)
    }
    
    func pause(with pauseType: PauseType) {
        pause(with: pauseType, completion: nil)
    }
}
