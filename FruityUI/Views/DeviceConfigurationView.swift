//
//  DeviceConfigurationView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit
import SwiftUI

struct DeviceConfigurationView: View {
    
    @EnvironmentObject var engine: Engine
    
    @State private var selectedSynapseVersion: SynapseVersion = .v2
    
    private var device: VersionedRazerDevice
    
    init(device: VersionedRazerDevice) {
        self.device = device
    }
    
    func delayedInit() {
        if self.engine.persistence.getStoredDataVersion(forVersionedDevice: self.device) == .v3 {
            self.selectedSynapseVersion = .v3
        } else {
            self.selectedSynapseVersion = .v2
        }
    }
    
    var body: some View {
        switch device {
        case let .v2(device):
            return AnyView(DeviceConfigurationViewV2(presenter: .init(device: device, engine: engine)))
        case let .v3(device):
            return AnyView(DeviceConfigurationViewV3(presenter: .init(device: device, engine: engine)))
        case let .both(v2: v2, v3: v3):
            return AnyView(VStack {
                DeviceConfigurationVersionPicker(selectedVersion: $selectedSynapseVersion)
                    .padding()
                
                if selectedSynapseVersion == .v2 {
                    DeviceConfigurationViewV2(presenter: .init(device: v2, engine: engine))
                } else {
                    DeviceConfigurationViewV3(presenter: .init(device: v3, engine: engine))
                }
            }.onAppear(perform: self.delayedInit))
        }
    }
}

struct DeviceConfigurationView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ForEach(FruityRazer.groupedConnectedDevices, id: \.self) {
                DeviceConfigurationView(device: $0)
            }
        }
    }
}
