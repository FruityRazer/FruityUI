//
//  AppDelegate.swift
//  FruityUILaunchHelper
//
//  Created by Eduardo Almeida on 08/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppIdentifier = BundleIdentifier.mainApp.rawValue
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killLauncher, object: mainAppIdentifier)

            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("FruityUI")

            let newPath = NSString.path(withComponents: components)

            NSWorkspace.shared.launchApplication(newPath)
        } else {
            self.terminate()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func terminate() {
        NSApp.terminate(nil)
    }
}

