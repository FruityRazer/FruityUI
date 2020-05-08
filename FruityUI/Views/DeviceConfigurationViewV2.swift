//
//  DeviceConfigurationViewV2.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

enum Synapse2ModeBasic: String, CaseIterable {
    case wave = "Wave"
    case spectrum = "Spectrum"
    case reactive = "Reactive"
    case `static` = "Static"
    case breath = "Breath"
}

struct DeviceConfigurationViewV2: View {
    var device: Device
    
    @State var selectedMode: Synapse2ModeBasic = .wave
    
    init(device: Device) {
        self.device = device
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Device selected: \(device.fullName)")
                    .padding()
                Picker(selection: $selectedMode, label: EmptyView()) {
                    ForEach(Synapse2ModeBasic.allCases, id: \.rawValue) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .padding()
                modeSettings
                    .padding()
                Button(action: {}) {
                    Text("Save")
                }
            }
            .padding()
            .frame(minWidth: 700)
        }
    }
    
    var modeSettings: AnyView? {
        switch selectedMode {
        case .wave:
            return AnyView(Wave(direction: .constant(.right)))
        default:
            return nil
        }
    }
}

struct DeviceConfigurationViewV2_Previews: PreviewProvider {
    static var previews: some View {
        DeviceConfigurationViewV2(device: StubDevice(shortName: "synapse2",
                                                     fullName: "Synapse 2 Device",
                                                     connected: true))
    }
}
