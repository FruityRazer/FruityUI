//
//  Synapse2Handle+Extensions.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 02/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit

extension Synapse2Handle {
    
    public func lightsOut() {
        write(mode: .static(color: .init(red: 0, green: 0, blue: 0)))
    }
}
