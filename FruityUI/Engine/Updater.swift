//
//  Updater.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 24/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

enum PauseType {
    case lightsOut
    case none
}

protocol Updater {
    
    func updateWithSavedConfigurations()
    func pause(with: PauseType)
}
