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
    
    private let devices: [VersionedRazerDevice]
    
    @Binding private var selectedDevice: VersionedRazerDevice?
    @State private var filter: FilterOption = .connected
    
    init(devices: [VersionedRazerDevice] = FruityRazer.sortedGroupedDevices(onlyConnected: false),
         selectedDevice: Binding<VersionedRazerDevice?> = .constant(nil)) {
        self.devices = devices
        self._selectedDevice = selectedDevice
    }
    
    var body: some View {
        VStack {
            Filter(selected: self.$filter).padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
            List(selection: self.$selectedDevice) {
                ForEach(self.devices.filter { (filter == .connected ? $0.connected : true) }, id: \.shortName) { device in
                    DeviceRow(device: device).tag(device)
                }
            }
        }.frame(minWidth: 225, maxWidth: 300, minHeight: 450)
    }
}

struct DeviceList_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceList(devices: [])
    }
}
