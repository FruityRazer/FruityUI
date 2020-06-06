//
//  DeviceConfigurationViewV2.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

struct DeviceConfigurationViewV2: View {
    
    enum Synapse2ModeBasic: String, CaseIterable {
        case wave = "Wave"
        case spectrum = "Spectrum"
        case reactive = "Reactive"
        case `static` = "Static"
        case breath = "Breath"
    }
    
    @ObservedObject var presenter: DeviceConfigurationViewV2.Presenter
    
    var body: some View {
        let selectedModeBinding = Binding<Synapse2ModeBasic>(
            get: { self.presenter.selectedMode },
            set: {
                self.presenter.perform(.setMode($0))
            }
        )
        
        return ScrollView {
            VStack {
                Text("Device selected: \(presenter.device.fullName)")
                    .padding()
                GroupBox(label: Text("Mode")) {
                    Picker(selection: selectedModeBinding, label: EmptyView()) {
                        ForEach(Synapse2ModeBasic.allCases, id: \.rawValue) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                }
                .padding()
                modeSettings
                    .padding()
                Button(action: { self.presenter.perform(.commit) }) {
                    Text("Save")
                }
            }
            .padding()
            .frame(minWidth: 700)
        }
    }
    
    var modeSettings: AnyView? {
        switch presenter.selectedMode {
        case .wave:
            return AnyView(Wave(mode: $presenter.synapseMode))
        case .spectrum:
            return AnyView(Spectrum(mode: $presenter.synapseMode))
        case .reactive:
            return AnyView(Reactive(mode: $presenter.synapseMode))
        case .static:
            return AnyView(Static(mode: $presenter.synapseMode))
        case .breath:
            return AnyView(Breath(mode: $presenter.synapseMode))
        }
    }
}

struct DeviceConfigurationViewV2_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceConfigurationViewV2(presenter: .init(device: StubDevice.exampleDevices[0],
                                                   engine: Engine()))
    }
}
