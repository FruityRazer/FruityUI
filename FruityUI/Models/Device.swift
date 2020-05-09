//
//  Device.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

protocol Device {
    var shortName: String { get }
    var fullName: String { get }
    var connected: Bool { get }
    var imageURL: URL { get }
    
    var razerDevice: RazerDevice? { get }
}

