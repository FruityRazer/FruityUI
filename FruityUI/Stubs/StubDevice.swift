//
//  StubDevice.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

struct StubDevice: Device {
    
    let shortName: String
    let fullName: String
    let connected: Bool
    let imageURL: URL = URL(string: "https://fruityrazer.github.io/")!
    
    var razerDevice: RazerDevice {
        fatalError("A Razer device handle does not exist on a stub device, so attempting to acquire that handle is an error.")
    }
    
    static let exampleDevices = [
        StubDevice(shortName: "huntsman_elite", fullName: "Razer Huntsman Elite", connected: true),
        StubDevice(shortName: "lycosa", fullName: "Razer Lycosa", connected: false)
    ]
}
