//
//  DeviceList.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 21/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

struct DeviceList: View {
    private let devices: [RazerDevice]
    
    @Binding private var selectedDevice: RazerDevice?
    
    init(devices: [RazerDevice] = FruityRazer.devices, selectedDevice: Binding<RazerDevice?>) {
        self.devices = devices
        self._selectedDevice = selectedDevice
    }
    
    var body: some View {
        List(selection: $selectedDevice) {
            ForEach(devices, id: \.shortName) { device in
                DeviceRow(device: device).tag(device)
            }
        }
    }
}

struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        DeviceList(devices: [], selectedDevice: .constant(nil))
    }
}
