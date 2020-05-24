//
//  NSPersistentContainer+Convenience.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 23/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

//  https://cocoacasts.com/setting-up-the-core-data-stack-with-nspersistentcontainer

import AppKit
import CoreData

extension NSPersistentContainer {
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

enum CoreData {
    
    static var managedContext: NSManagedObjectContext? {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    static func commit() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.persistentContainer.saveContext()
    }
}
