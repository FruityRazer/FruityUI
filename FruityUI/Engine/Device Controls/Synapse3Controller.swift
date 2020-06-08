//
//  Synapse3Updater.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

struct Synapse3Controller: DeviceControlling {
    
    typealias DeviceConfigurationWithHandle = (configuration: DeviceConfigurationV3, handle: Synapse3Handle)
    
    private var configurations: [DeviceConfigurationWithHandle] {
        let allConfigurations = DeviceConfigurationV3.get()
        
        return FruityRazer.connectedDevices
            .filter { $0.driver.synapseVersion == 3 }
            .compactMap { connectedDevice in
                guard let configuration = allConfigurations.first(where: { $0.shortName == connectedDevice.shortName }) else {
                    return nil
                }
                
                guard case let Driver.v3(driver: handle) = connectedDevice.driver else {
                    return nil
                }
                
                return (configuration, handle)
        }
    }
    
    func updateWithSavedConfigurations() {
        configurations.forEach {
            _ = $0.handle.write(mode: $0.configuration.mode)
        }
    }
    
    func pause(with: PauseType) {
        configurations.forEach {
            _ = $0.handle.write(mode: .off)
        }
    }
}
