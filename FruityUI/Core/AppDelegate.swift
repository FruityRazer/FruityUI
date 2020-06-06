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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        engine = Engine()
        router = Router(engine: engine)
        
        engine.deviceController.startUpdating()
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.squareLength))
        
        statusBarItem.button?.image = ResourceHelpers.statusBarImage
        
        statusBarMenuController = StatusBarItemController(engine: engine,
                                                          router: router,
                                                          statusBarItem: statusBarItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
