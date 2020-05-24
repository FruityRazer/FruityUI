//
//  DeviceConfigurationV2+SynapseMode.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 23/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import CoreData
import FruityKit

extension DeviceConfigurationV2 {
    
    var synapseMode: Synapse2Handle.Mode {
        switch mode {
        case .wave:
            return .wave(direction: direction.fruityKitDirection)
        case .spectrum:
            return .spectrum
        case .reactive:
            return .reactive(speed: Int(speed), color: color!)
        case .static:
            return .static(color: color!)
        case .breath:
            return .breath(color: color!)
        }
    }
}
