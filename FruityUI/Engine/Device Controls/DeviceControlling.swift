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
    
    func updateWithSavedConfigurations()
    func pause(with: PauseType)
}
