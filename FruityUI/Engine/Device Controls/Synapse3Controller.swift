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
    
    func updateWithSavedConfigurations(completion: CompletionBlock?) {
        guard configurations.count > 0 else {
            completion?()
            
            return
        }
        
        var remaining = configurations.count
        
        configurations.forEach { c in
            DispatchQueue.global(qos: .default).async {
                _ = c.handle.write(mode: c.configuration.mode)
                
                remaining -= 1
                
                if remaining == 0 {
                    completion?()
                }
            }
        }
    }
    
    func pause(with: PauseType, completion: CompletionBlock?) {
        guard configurations.count > 0 else {
            completion?()
            
            return
        }
        
        var remaining = configurations.count
        
        configurations.forEach { c in
            DispatchQueue.global(qos: .default).async {
                _ = c.handle.write(mode: .off)
                
                remaining -= 1
                
                if remaining == 0 {
                    completion?()
                }
            }
        }
    }
}
