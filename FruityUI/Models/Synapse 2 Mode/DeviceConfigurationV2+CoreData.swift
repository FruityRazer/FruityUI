//
//  DeviceConfigurationV2+CoreData.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 23/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit
import CoreData
import FruityKit

extension DeviceConfigurationV2 {
    
    private class func new() -> DeviceConfigurationV2? {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "DeviceConfigurationV2", in: managedContext)!
        
        let deviceConfiguration = NSManagedObject(entity: entity, insertInto: managedContext)
        
        return (deviceConfiguration as! DeviceConfigurationV2)
    }
    
    @discardableResult class func new(withShortName shortName: String, mode: Synapse2Handle.Mode) -> DeviceConfigurationV2? {
        guard let configuration = DeviceConfigurationV2.new() else {
            return nil
        }
        
        configuration.shortName = shortName
        
        switch mode {
        case let .wave(direction):
            configuration.mode = .wave
            configuration.direction = direction.coreDataDirection
        case .spectrum:
            configuration.mode = .spectrum
        case let .reactive(speed, color):
            configuration.mode = .reactive
            configuration.speed = speed
            configuration.color = color
        case let .static(color):
            configuration.mode = .static
            configuration.color = color
        case let .breath(color):
            configuration.mode = .breath
            configuration.color = color
        }
        
        CoreData.commit()
        
        return configuration
    }
    
    class func get() -> [DeviceConfigurationV2] {
        guard let managedContext = CoreData.managedContext else {
            return []
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceConfigurationV2")
        
        do {
            return try managedContext.fetch(fetchRequest) as! [DeviceConfigurationV2]
        } catch {
            
        }
        
        return []
    }
    
    class func get(forDeviceWithShortName shortName: String) -> DeviceConfigurationV2? {
        guard let managedContext = CoreData.managedContext else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceConfigurationV2")
        
        fetchRequest.predicate = NSPredicate(format: "shortName == %@", shortName)
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [DeviceConfigurationV2]
            
            if let result = fetchedResults.first {
                return result
            }
        } catch {
            
        }
        
        return nil
    }
    
    class func delete(forDeviceWithShortName shortName: String) {
        guard let managedContext = CoreData.managedContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceConfigurationV2")
        
        fetchRequest.predicate = NSPredicate(format: "shortName == %@", shortName)
        
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(request)
        } catch {
            fatalError("Failed to execute request: \(error)")
        }
    }
}

private extension Direction {
    
    var coreDataDirection: DeviceConfigurationV2Direction {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}
