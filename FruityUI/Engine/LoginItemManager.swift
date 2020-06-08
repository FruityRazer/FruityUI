//
//  LoginItemManager.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import ServiceManagement

protocol LoginItemManaging {
    
    func toggle()
    
    var openAtLogin: Bool { get set }
}

class LoginItemManager : LoginItemManaging {
    
    func toggle() {
        self.openAtLogin = !openAtLogin
    }
    
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
