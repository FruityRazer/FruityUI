//
//  DeviceConfigurationV3+Extensions.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

extension DeviceConfigurationV3 {
    
    var colors: [[Color]] {
        
        get {
            colorsRaw.map { row in
                row.map { components in
                    Color(red: components[0], green: components[1], blue: components[2])
                }
            }
        }
        
        set {
            colorsRaw = newValue.map { row in
                row.map { color in
                    [color.r, color.g, color.b]
                }
            }
        }
    }
}
