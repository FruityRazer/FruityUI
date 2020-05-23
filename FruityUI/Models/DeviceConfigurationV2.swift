//
//  DeviceConfigurationV2.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import CoreData
import Foundation

private let InvalidEntry = UInt8.max

@objc enum DeviceConfigurationV2Mode: UInt8 {
    
    case wave = 1
    case spectrum = 2
    case reactive = 3
    case `static` = 4
    case breath = 5
}

@objc enum DeviceConfigurationV2ModeDirection: UInt8 {
    
    case left = 1
    case right = 2
}

@objc(DeviceConfigurationV2)
class DeviceConfigurationV2: NSManagedObject {
    
    @NSManaged var colorRaw: [UInt8]?
    @NSManaged var direction: DeviceConfigurationV2ModeDirection
    @NSManaged var mode: DeviceConfigurationV2Mode
    @NSManaged var shortName: String
    @NSManaged var speed: UInt8
}
