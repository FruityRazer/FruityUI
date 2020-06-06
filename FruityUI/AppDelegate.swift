//
//  AppDelegate.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 19/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var engine: Engine!
    var router: Routable!
    var statusBarMenuController: StatusBarItemController!
    
    var statusBarItem: NSStatusItem!
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()

    lazy var statusBarImage: NSImage = {
        let newSize = NSSize(width: 20, height: 20)
        
        let sourceImage = NSImage(named: "FruityRazerGray")
        
        let newImage = NSImage(size: newSize)
        newImage.lockFocus()
        
        sourceImage?.size = newSize
        
        NSGraphicsContext.current?.imageInterpolation = .high
        
        sourceImage?.draw(at: .zero, from: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height), operation: .copy, fraction: 1.0)
        
        newImage.unlockFocus()
        
        return newImage
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        engine = Engine()
        router = Router(engine: engine)
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.squareLength))
        
        statusBarItem.button?.image = statusBarImage
        
        statusBarMenuController = StatusBarItemController(router: router, statusBarItem: statusBarItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
