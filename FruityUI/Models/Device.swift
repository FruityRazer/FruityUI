//
//  Device.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

typealias Device = HasDeviceDriver & HasDeviceMetadata

extension RazerDevice: HasDeviceMetadata {}
extension VersionedRazerDevice: HasDeviceMetadata {}
