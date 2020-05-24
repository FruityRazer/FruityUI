//
//  Synapse2Updater.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 24/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

struct Synapse2Updater: Updater {
    
    typealias DeviceConfigurationWithHandle = (configuration: DeviceConfigurationV2, handle: Synapse2Handle)
    
    private var configurations: [DeviceConfigurationWithHandle] {
        let allConfigurations = DeviceConfigurationV2.get()
        
        return FruityRazer.connectedDevices
            .filter { $0.driver.synapseVersion == 2 }
            .compactMap { connectedDevice in
                guard let configuration = allConfigurations.first(where: { $0.shortName == connectedDevice.shortName }) else {
                    return nil
                }
                
                guard case let Driver.v2(driver: handle) = connectedDevice.driver else {
                    return nil
                }
                
                return (configuration, handle)
        }
    }
    
    func updateWithSavedConfigurations() {
        configurations.forEach {
            $0.handle.write(mode: $0.configuration.synapseMode)
        }
    }
    
    func pause(with: PauseType) {
        
    }
}
