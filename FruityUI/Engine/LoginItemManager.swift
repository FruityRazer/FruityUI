//
//  LoginItemManager.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

//  Workaround to silence deprecation warnings: https://stackoverflow.com/a/45743766

import Foundation
import ServiceManagement

protocol LoginItemManaging {
    
    func toggle()
    
    var openAtLogin: Bool { get set }
}

class LoginItemManager : LoginItemManaging {
    
    @available(macOS, deprecated: 10.10)
    func toggle() {
        self.openAtLogin = !openAtLogin
    }
    
    @available(macOS, deprecated: 10.10)
    var openAtLogin: Bool {
        get {
            guard let jobs = (SMCopyAllJobDictionaries(kSMDomainUserLaunchd).takeRetainedValue() as? [[String: AnyObject]]) else {
                return false
            }

            let job = jobs.first { $0["Label"] as! String == BundleIdentifier.launchHelper.rawValue }

            return job?["OnDemand"] as? Bool ?? false
        }
        
        set {
            SMLoginItemSetEnabled(BundleIdentifier.launchHelper.rawValue as CFString, newValue)
        }
    }
}
