//
//  Synapse2Updater.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 24/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

struct Synapse2Controller: DeviceControlling {
    
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
    
    func updateWithSavedConfigurations(completion: CompletionBlock?) {
        guard configurations.count > 0 else {
            completion?()
            
            return
        }
        
        var remaining = configurations.count
        
        configurations.forEach { c in
            DispatchQueue.global(qos: .default).async {
                _ = c.handle.write(mode: c.configuration.synapseMode)
                
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
                _ = c.handle.write(mode: .static(color: .init(red: 0, green: 0, blue: 0)))
                
                remaining -= 1
                
                if remaining == 0 {
                    completion?()
                }
            }
        }
    }
}
