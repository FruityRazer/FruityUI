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
    var statusBarItemController: StatusBarItemController!
    
    var statusBarItem: NSStatusItem!
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "DataModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            let remoteChangeKey = "NSPersistentStoreRemoteChangeNotificationOptionKey"
            storeDescription.setOption(true as NSNumber,
                                       forKey: remoteChangeKey)
        }
        
        return container
    }()
    
    private func killLaunchHelperIfRunning() {
        let launcherAppId = BundleIdentifier.launchHelper.rawValue
        let runningApps = NSWorkspace.shared.runningApplications
        
        if !runningApps.filter({ $0.bundleIdentifier == launcherAppId }).isEmpty {
            DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        killLaunchHelperIfRunning()
        
        engine = Engine()
        router = Router(engine: engine)
        
        engine.deviceController.startUpdates()
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.squareLength))
        
        statusBarItem.button?.image = ResourceHelpers.statusBarImage
        
        statusBarItemController = StatusBarItemController(engine: engine,
                                                          router: router,
                                                          statusBarItem: statusBarItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
