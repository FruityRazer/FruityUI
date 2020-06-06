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
                GroupBox(label: Text("Raw Data")) {
                    MacEditorTextView(
                        text: $rawConfigurationText,
                        isEditable: true,
                        font: .userFixedPitchFont(ofSize: 14)
                    )
                    .frame(minWidth: 300,
                           maxWidth: .infinity,
                           minHeight: 200,
                           maxHeight: .infinity)
                }.padding()
                Button(action: { }) {
                    Text("Save")
                }
            }
                .padding()
                .frame(minWidth: 700)
        }
    }
}

struct DeviceConfigurationViewV3_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceConfigurationViewV3(device: StubDevice.exampleDevices[0])
    }
}
