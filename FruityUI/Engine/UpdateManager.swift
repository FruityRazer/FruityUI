//
//  UpdateManager.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 20/03/2021.
//  Copyright © 2021 Eduardo Almeida. All rights reserved.
//

import Foundation
import Sparkle

protocol UpdateManaging {
    
    var automaticallyCheckForUpdates: Bool { get set }
    
    func checkForUpdates()
}

class UpdateManager: NSObject, UpdateManaging {
    
    let userDriver: SPUUserDriver = SPUStandardUserDriver(hostBundle: Bundle.main, delegate: nil)
    let updater: SPUUpdater
    
    override init() {
        self.updater = SPUUpdater(hostBundle: Bundle.main,
                                  applicationBundle: Bundle.main,
                                  userDriver: userDriver,
                                  delegate: nil)
        
        do {
            try self.updater.start()
        } catch {
            assertionFailure("Failed to initalize updater: \(error)")
        }
    }
    
    var automaticallyCheckForUpdates: Bool {
        get {
            updater.automaticallyChecksForUpdates
        }
        
        set {
            updater.automaticallyChecksForUpdates = newValue
            
            UserDefaults.standard.synchronize()
        }
    }
    
    func checkForUpdates() {
        print("Checking for updates at \(updater.feedURL)")
        
        updater.checkForUpdates()
    }
}
