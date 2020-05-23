//
//  DeviceConfigurationV2+Extensions.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 23/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit
import CoreData
import FruityKit

extension DeviceConfigurationV2 {
    
    @nonobjc public class func new() -> DeviceConfigurationV2? {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "DeviceConfigurationV2", in: managedContext)!
        
        let deviceConfiguration = NSManagedObject(entity: entity, insertInto: managedContext)
        
        return (deviceConfiguration as! DeviceConfigurationV2)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceConfigurationV2> {
        return NSFetchRequest<DeviceConfigurationV2>(entityName: "DeviceConfigurationV2")
    }
    
    var color: Color? {
        get {
            guard let components = colorRaw, components.count == 3 else {
                return nil
            }
            
            return Color(red: components[0], green: components[1], blue: components[2])
        }
        
        set {
            guard let c = newValue else {
                colorRaw = nil
                
                return
            }
            
            colorRaw = [c.r, c.g, c.b]
        }
    }
}

extension DeviceConfigurationV2ModeDirection {
    
    var fruityKitDirection: Direction {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}
