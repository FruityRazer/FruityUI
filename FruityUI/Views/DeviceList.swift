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
    @Binding private var filter: FilterOption
    
    init(devices: [RazerDevice] = FruityRazer.devices, selectedDevice: Binding<RazerDevice?>, filter: Binding<FilterOption> = .constant(.all)) {
        self.devices = devices
        self._selectedDevice = selectedDevice
        self._filter = filter
    }
    
    var body: some View {
        VStack {
            Filter(selected: self.$filter)
            List(selection: self.$selectedDevice) {
                ForEach(self.devices, id: \.shortName) { device in
                    DeviceRow(device: device).tag(device)
                }
            }
        }.frame(minWidth: 225, maxWidth: 300)
    }
}

struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        DeviceList(devices: [], selectedDevice: .constant(nil))
    }
}
