//
//  DeviceConfigurationV3+CoreData.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit
import CoreData
import FruityKit

extension DeviceConfigurationV3 {
    
    private class func new() -> DeviceConfigurationV3? {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "DeviceConfigurationV3", in: managedContext)!
        
        let deviceConfiguration = NSManagedObject(entity: entity, insertInto: managedContext)
        
        return (deviceConfiguration as! DeviceConfigurationV3)
    }
    
    @discardableResult class func new(withShortName shortName: String, mode: Synapse3Handle.Mode) -> DeviceConfigurationV3? {
        guard let configuration = DeviceConfigurationV3.new() else {
            return nil
        }
        
        configuration.shortName = shortName
        
        switch mode {
        case let .raw(colors: colors):
            configuration.colors = [colors]
        case let .rawRows(colors: colorRows):
            configuration.colors = colorRows
        }
        
        CoreData.commit()
        
        return configuration
    }
    
    class func get() -> [DeviceConfigurationV3] {
        guard let managedContext = CoreData.managedContext else {
            return []
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceConfigurationV3")
        
        do {
            return try managedContext.fetch(fetchRequest) as! [DeviceConfigurationV3]
        } catch {
            
        }
        
        return []
    }
    
    class func get(forDeviceWithShortName shortName: String) -> DeviceConfigurationV3? {
        guard let managedContext = CoreData.managedContext else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceConfigurationV3")
        
        fetchRequest.predicate = NSPredicate(format: "shortName == %@", shortName)
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [DeviceConfigurationV3]
            
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
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceConfigurationV3")
        
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
