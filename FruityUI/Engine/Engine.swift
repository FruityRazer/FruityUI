//
//  Engine.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 07/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

class Engine {
    
    let deviceController: Controlling
    let persistence: Persisting
    
    init(deviceController: Controlling = Controller(),
         persistence: Persisting = Persistence()) {
        
        self.deviceController = deviceController
        self.persistence = persistence
    }
}

extension Engine: ObservableObject {}
