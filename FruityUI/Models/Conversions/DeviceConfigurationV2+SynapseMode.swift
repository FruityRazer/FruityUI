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

extension Synapse2Handle.Mode {
    
    func save() {
        guard let configuration = DeviceConfigurationV2.new() else {
            return
        }
        
        switch self {
        case let .wave(direction):
            configuration.mode = .wave
            configuration.direction = direction.coreDataDirection
        case .spectrum:
            configuration.mode = .spectrum
        case let .reactive(speed, color):
            configuration.mode = .reactive
            configuration.speed = UInt8(speed)
            configuration.color = color
        case let .static(color):
            configuration.mode = .static
            configuration.color = color
        case let .breath(color):
            configuration.mode = .breath
            configuration.color = color
        }
        
        CoreData.commit()
    }
}

private extension Direction {
    
    var coreDataDirection: DeviceConfigurationV2ModeDirection {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}
