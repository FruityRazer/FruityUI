//
//  DeviceConfigurationV3.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import CoreData

@objc(DeviceConfigurationV3)
class DeviceConfigurationV3: NSManagedObject {
    @NSManaged var colorsRaw: [[[UInt8]]]
    @NSManaged var shortName: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceConfigurationV3> {
        return NSFetchRequest<DeviceConfigurationV3>(entityName: "DeviceConfigurationV3")
    }
}
