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
        case .breath:
            return .breath(color: color!)
        case .reactive:
            return .reactive(speed: Int(speed), color: color!)
        case .spectrum:
            return .spectrum
        case .starlight:
            return .starlight(speed: Int(speed), color1: color1!, color2: color2!)
        case .static:
            return .static(color: color!)
        case .wave:
            return .wave(direction: direction.fruityKitDirection)
        }
    }
}
