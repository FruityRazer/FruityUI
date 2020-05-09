//
//  DeviceConfigurationView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

struct DeviceConfigurationViewV3: View {
    var device: Device
    @Binding var rawConfigurationText: String
    
    init(device: Device) {
        self.device = device
        self._rawConfigurationText = .constant("")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Device selected: \(device.fullName)")
                    .padding()
                TextField("", text: $rawConfigurationText).padding()
            }.frame(minWidth: 700)
        }
    }
}

struct DeviceConfigurationViewV3_Previews: PreviewProvider {
    static var previews: some View {
        DeviceConfigurationViewV3(device: StubDevice.exampleDevices[0])
    }
}
