//
//  HasDeviceMetadata.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 01/07/2021.
//  Copyright © 2021 Eduardo Almeida. All rights reserved.
//

import Foundation

protocol HasDeviceMetadata {
    
    var shortName: String { get }
    var fullName: String { get }
    var connected: Bool { get }
    var imageURL: URL { get }
}
