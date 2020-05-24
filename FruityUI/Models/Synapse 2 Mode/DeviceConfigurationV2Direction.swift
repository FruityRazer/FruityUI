//
//  DeviceConfigurationV2Direction.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 24/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

@objc enum DeviceConfigurationV2Direction: UInt8 {
    
    case left = 1
    case right = 2
}

extension DeviceConfigurationV2Direction {
    
    var fruityKitDirection: Direction {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}
