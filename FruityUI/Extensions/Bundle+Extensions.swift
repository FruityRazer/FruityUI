//
//  Bundle+Extensions.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 16/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

extension Bundle {
    
    var shortVersion: String {
        (object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? ""
    }
    
    var version: String {
        (object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? ""
    }
}
