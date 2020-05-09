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
    
    var device: Device
    
    @State var selectedMode: Synapse2ModeBasic = .wave
    @State var synapseMode: Synapse2Handle.Mode? = .wave(direction: .right)
    
    init(device: Device) {
        self.device = device
    }
    
    var body: some View {
        let selectedModeBinding = Binding<Synapse2ModeBasic>(
            get: { self.selectedMode },
            set: {
                self.selectedMode = $0
                
                let white = FruityKit.Color(red: 255, green: 255, blue: 255)
                
                switch $0 {
                case .wave:
                    self.synapseMode = .wave(direction: .right)
                case .spectrum:
                    self.synapseMode = .spectrum
                case .reactive:
                    self.synapseMode = .reactive(speed: 1, color: white)
                case .static:
                    self.synapseMode = .static(color: white)
                case .breath:
                    self.synapseMode = .breath(color: white)
                }
            }
        )
        
        return ScrollView {
            VStack {
                Text("Device selected: \(device.fullName)")
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
                Button(action: commitToDevice) {
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
            return AnyView(Wave(mode: $synapseMode))
        case .spectrum:
            return AnyView(Spectrum(mode: $synapseMode))
        case .reactive:
            return AnyView(Reactive(mode: $synapseMode))
        case .static:
            return AnyView(Static(mode: $synapseMode))
        case .breath:
            return AnyView(Breath(mode: $synapseMode))
        }
    }
    
    func commitToDevice() {
        guard let razerDevice = device.razerDevice else {
            assertionFailure("`razerDevice` should never be nil on a non-stub device driver.")
            
            return
        }
        
        guard case let Driver.v2(driver: handle) = razerDevice.driver else {
            assertionFailure("Driver should be of Synapse2 type.")
            
            return
        }
        
        guard let mode = synapseMode else {
            //  Nothing to write...
            
            return
        }
        
        handle.write(mode: mode)
    }
}

struct DeviceConfigurationViewV2_Previews: PreviewProvider {
    static var previews: some View {
        DeviceConfigurationViewV2(device: StubDevice.exampleDevices[0])
    }
}
