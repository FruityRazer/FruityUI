//
//  Persistence.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

protocol Persisting {
    
    func getStoredDataVersion(forVersionedDevice device: VersionedRazerDevice) -> SynapseVersion?
    
    func setMode(_ mode: Synapse2Handle.Mode, forDeviceWithShortName shortName: String)
    func setMode(_ mode: Synapse3Handle.Mode, forDeviceWithShortName shortName: String)
}

struct Persistence: Persisting {
    
    private func deleteConfigurations(forDeviceWithShortName shortName: String) {
        if shortName.hasSuffix("_hw") {
            DeviceConfigurationV2.delete(forDeviceWithShortName: shortName)
            DeviceConfigurationV3.delete(forDeviceWithShortName: String(shortName.dropLast(3)) + "_sw")
        } else if shortName.hasSuffix("_sw") {
            DeviceConfigurationV2.delete(forDeviceWithShortName: String(shortName.dropLast(3)) + "_hw")
            DeviceConfigurationV3.delete(forDeviceWithShortName: shortName)
        } else {
            DeviceConfigurationV2.delete(forDeviceWithShortName: shortName)
            DeviceConfigurationV3.delete(forDeviceWithShortName: shortName)
        }
    }
    
    func getStoredDataVersion(forVersionedDevice device: VersionedRazerDevice) -> SynapseVersion? {
        guard case let VersionedRazerDevice.both(v2: v2, v3: v3) = device else {
            return nil
        }
        
        if DeviceConfigurationV2.get(forDeviceWithShortName: v2.shortName) != nil {
            return .v2
        }
        
        if DeviceConfigurationV3.get(forDeviceWithShortName: v3.shortName) != nil {
            return .v3
        }
        
        return nil
    }
    
    func setMode(_ mode: Synapse2Handle.Mode, forDeviceWithShortName shortName: String) {
        deleteConfigurations(forDeviceWithShortName: shortName)
        
        DeviceConfigurationV2.new(withShortName: shortName, mode: mode)
    }
    
    func setMode(_ mode: Synapse3Handle.Mode, forDeviceWithShortName shortName: String) {
        deleteConfigurations(forDeviceWithShortName: shortName)
        
        DeviceConfigurationV3.new(withShortName: shortName, mode: mode)
    }
}
