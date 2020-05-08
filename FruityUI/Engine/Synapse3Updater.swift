//
//  Synapse3Updater.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

protocol Synapse3Updating {
    
}

struct Synapse3Updater: Synapse3Updating {
    let configurations: [DeviceConfigurationV3]
    
    init(configurations: [DeviceConfigurationV3]) {
        self.configurations = configurations
    }
    
    func update() {
        FruityRazer.connectedDevices.forEach { device in
            guard let configuration = configurations.first(where: { configuration in configuration.shortName == device.shortName }),
                case let Driver.v3(driver: handle) = device.driver else {
                return
            }
            
            //  Do something with `configuration` and `handle`...
        }
    }
}
