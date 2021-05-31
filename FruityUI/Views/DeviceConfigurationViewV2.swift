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
        
        case breath = "Breath"
        case reactive = "Reactive"
        case spectrum = "Spectrum"
        case starlight = "Starlight"
        case `static` = "Static"
        case wave = "Wave"
    }
    
    @ObservedObject var presenter: DeviceConfigurationViewV2.Presenter
    
    var body: some View {
        let selectedModeBinding = Binding<Synapse2ModeBasic>(
            get: { self.presenter.selectedMode },
            set: {
                self.presenter.perform(.setMode($0))
            }
        )
        
        let showingErrorBinding = Binding<Bool>(
            get: { self.presenter.showingError },
            set: { _ in self.presenter.perform(.dismissError) }
        )
        
        return ScrollView {
            VStack {
                GroupBox(label: Text("Mode")) {
                    Picker(selection: selectedModeBinding, label: EmptyView()) {
                        ForEach(presenter.availableModes, id: \.rawValue) {
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
        }.alert(isPresented: showingErrorBinding) {
            Alert(title: Text("Error!"), message: Text(self.presenter.error!), dismissButton: .default(Text("Ok")))
        }
    }
    
    @ViewBuilder
    var modeSettings: some View {
        switch presenter.selectedMode {
        case .breath:
            Breath(mode: $presenter.synapseMode)
        case .reactive:
            Reactive(mode: $presenter.synapseMode, speedSupported: presenter.speedSupported)
        case .spectrum:
            Spectrum(mode: $presenter.synapseMode)
        case .starlight:
            Starlight(mode: $presenter.synapseMode, speedSupported: presenter.speedSupported)
        case .static:
            Static(mode: $presenter.synapseMode)
        case .wave:
            Wave(mode: $presenter.synapseMode, speedSupported: presenter.speedSupported)
        }
    }
}

struct DeviceConfigurationViewV2_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceConfigurationViewV2(presenter: .init(device: StubDevice.exampleDevices[0],
                                                   engine: Engine()))
    }
}
