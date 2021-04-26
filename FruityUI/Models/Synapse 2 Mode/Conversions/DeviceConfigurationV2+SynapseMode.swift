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
            let c = color ?? .white
            
            return .breath(color: c)
            
        case .reactive:
            let c = color ?? .white
            
            return .reactive(speed: Int(speed), color: c)
            
        case .spectrum:
            return .spectrum
            
        case .starlight:
            let c1 = color1 ?? .white
            let c2 = color2 ?? .white
            
            return .starlight(speed: Int(speed), color1: c1, color2: c2)
            
        case .static:
            let c = color ?? .white
            
            return .static(color: c)
            
        case .wave:
            return .wave(direction: direction.fruityKitDirection)
        }
    }
}
