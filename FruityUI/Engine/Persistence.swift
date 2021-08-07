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
    
    func deleteConfigurations(forDeviceWithShortName shortName: String)
    
    func getStoredDataVersion(forVersionedDevice device: VersionedRazerDevice) -> SynapseVersion?
    
    func deviceHasStoredData(_ device: VersionedRazerDevice) -> Bool
    
    func setMode(_ mode: Synapse2Handle.Mode, forDeviceWithShortName shortName: String)
    func setMode(_ mode: Synapse3Handle.Mode, forDeviceWithShortName shortName: String)
}

struct Persistence: Persisting {
    
    func deleteConfigurations(forDeviceWithShortName shortName: String) {
        if shortName.hasSuffix(Constants.synapse2Suffix) {
            DeviceConfigurationV2.delete(forDeviceWithShortName: shortName)
            DeviceConfigurationV3.delete(forDeviceWithShortName: String(shortName.dropLast(Constants.synapse2Suffix.count)) + Constants.synapse3Suffix)
        } else if shortName.hasSuffix(Constants.synapse3Suffix) {
            DeviceConfigurationV2.delete(forDeviceWithShortName: String(shortName.dropLast(Constants.synapse3Suffix.count)) + Constants.synapse2Suffix)
            DeviceConfigurationV3.delete(forDeviceWithShortName: shortName)
        } else {
            DeviceConfigurationV2.delete(forDeviceWithShortName: shortName)
            DeviceConfigurationV3.delete(forDeviceWithShortName: shortName)
        }
        
        NotificationCenter.default.post(Notification(name: .persistenceChanged))
    }
    
    func deviceHasStoredData(_ device: VersionedRazerDevice) -> Bool {
        switch device {
        case let .both(v2, v3):
            return DeviceConfigurationV2.get(forDeviceWithShortName: v2.shortName) != nil || DeviceConfigurationV3.get(forDeviceWithShortName: v3.shortName) != nil
        case let .v2(device):
            return DeviceConfigurationV2.get(forDeviceWithShortName: device.shortName) != nil
        case let .v3(device):
            return DeviceConfigurationV3.get(forDeviceWithShortName: device.shortName) != nil
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
        
        NotificationCenter.default.post(Notification(name: .persistenceChanged))
    }
    
    func setMode(_ mode: Synapse3Handle.Mode, forDeviceWithShortName shortName: String) {
        deleteConfigurations(forDeviceWithShortName: shortName)
        
        DeviceConfigurationV3.new(withShortName: shortName, mode: mode)
        
        NotificationCenter.default.post(Notification(name: .persistenceChanged))
    }
}
