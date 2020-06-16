//
//  FruityRazer+Extensions.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 15/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit

extension FruityRazer {
    
    static let sortFunction: (Device, Device) -> Bool = {
        $0.fullName < $1.fullName
    }
    
    static func sortedDevices(onlyConnected: Bool) -> [RazerDevice] {
        if onlyConnected {
            return FruityRazer.connectedDevices.sorted(by: sortFunction)
        } else {
            return FruityRazer.devices.sorted(by: sortFunction)
        }
    }
    
    static func sortedGroupedDevices(onlyConnected: Bool) -> [VersionedRazerDevice] {
        if onlyConnected {
            return FruityRazer.groupedConnectedDevices.sorted(by: sortFunction)
        } else {
            return FruityRazer.groupedDevices.sorted(by: sortFunction)
        }
    }
}
