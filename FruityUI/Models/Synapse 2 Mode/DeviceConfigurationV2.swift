//
//  DeviceConfigurationV2.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import CoreData
import Foundation
import FruityKit

@objc(DeviceConfigurationV2)
class DeviceConfigurationV2: NSManagedObject {
    
    static let EntityName = "DeviceConfigurationV2"
    
    @NSManaged private var colorRaw: [Int]?
    @NSManaged private var color2Raw: [Int]?
    @NSManaged private var directionRaw: Int
    @NSManaged private var modeRaw: Int
    @NSManaged var shortName: String
    @NSManaged var speed: Int
}

extension DeviceConfigurationV2 {
    
    var color: Color? {
        get {
            guard let components = colorRaw, components.count == 3 else {
                return nil
            }
            
            return Color(red: UInt8(components[0]), green: UInt8(components[1]), blue: UInt8(components[2]))
        }
        
        set {
            guard let c = newValue else {
                colorRaw = nil
                
                return
            }
            
            colorRaw = [Int(c.r), Int(c.g), Int(c.b)]
        }
    }
    
    var color1: Color? {
        get { color }
        set { color = newValue }
    }
    
    var color2: Color? {
        get {
            guard let components = color2Raw, components.count == 3 else {
                return nil
            }
            
            return Color(red: UInt8(components[0]), green: UInt8(components[1]), blue: UInt8(components[2]))
        }
        
        set {
            guard let c = newValue else {
                color2Raw = nil
                
                return
            }
            
            color2Raw = [Int(c.r), Int(c.g), Int(c.b)]
        }
    }
    
    var direction: DeviceConfigurationV2Direction {
        get {
            return DeviceConfigurationV2Direction(rawValue: UInt8(directionRaw))!
        }
        
        set {
            directionRaw = Int(newValue.rawValue)
        }
    }
    
    var mode: DeviceConfigurationV2Mode {
        get {
            return DeviceConfigurationV2Mode(rawValue: UInt8(modeRaw))!
        }
        
        set {
            modeRaw = Int(newValue.rawValue)
        }
    }
}
