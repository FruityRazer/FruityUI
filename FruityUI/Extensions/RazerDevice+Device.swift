//
//  RazerDevice+Device.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

extension HasDeviceMetadata {
    
    var imageURL: URL {
        guard let plistPath = Bundle.main.path(forResource: "DeviceImages", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: plistPath) as? Dictionary<String, String>,
            let urlStr = dictionary[shortName] else {
                return URLs.defaultImage
        }
        
        return URL(string: urlStr)!
    }
}

extension RazerDevice: HasDeviceDriver {
    
    var razerDevice: RazerDevice {
        return self
    }
}
