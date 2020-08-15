//
//  Engine.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 07/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

/// Engine of the app, class that handles shared objects used by the whole app.
/// Used basically to avoid passing around instances of every single one of these objects.

class Engine {
    
    let deviceController: Controlling
    var loginItemManager: LoginItemManaging
    let persistence: Persisting
    
    init(deviceController: Controlling = Controller(),
         loginItemManager: LoginItemManaging = LoginItemManager(),
         persistence: Persisting = Persistence()) {
        
        self.deviceController = deviceController
        self.loginItemManager = loginItemManager
        self.persistence = persistence
    }
}

extension Engine: ObservableObject {}
