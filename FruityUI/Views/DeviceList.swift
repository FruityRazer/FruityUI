//
//  DeviceList.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 21/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

struct Foo {
    
}

struct DeviceList: View {
    let devices = FruityRazer.devices
    
    @Binding var selectedDevice: RazerDevice?
    
    var body: some View {
        List(devices, id: \.shortName, selection: $selectedDevice) {
            DeviceRow(device: $0)
        }
    }
}

struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        DeviceList()
    }
}
