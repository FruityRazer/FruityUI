//
//  Synapse2HandleMode+Conversions.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 24/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit

extension Synapse2Handle.Mode {
    
    var synapse2ModeBasic: DeviceConfigurationViewV2.Synapse2ModeBasic {
        switch self {
        case .wave:
            return .wave
        case .spectrum:
            return .spectrum
        case .reactive:
            return .reactive
        case .static:
            return .static
        case .breath:
            return .breath
        }
    }
}
