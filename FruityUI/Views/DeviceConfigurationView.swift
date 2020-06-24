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
    
    typealias Action = () -> ()
    
    @EnvironmentObject var engine: Engine
    
    @State private var selectedSynapseVersion: SynapseVersion = .v2
    
    @State private var isPresentingDeleteAlert: Bool = false
    
    private var device: VersionedRazerDevice
    
    private var onConfigurationClose: Action?
    
    init(device: VersionedRazerDevice, onConfigurationClose: Action?) {
        self.device = device
        self.onConfigurationClose = onConfigurationClose
    }
    
    func loadData() {
        if self.engine.persistence.getStoredDataVersion(forVersionedDevice: self.device) == .v3 {
            self.selectedSynapseVersion = .v3
        } else {
            self.selectedSynapseVersion = .v2
        }
    }
    
    func deleteDeviceSettings() {
        self.engine.persistence.deleteConfigurations(forDeviceWithShortName: device.shortName)
        self.loadData()
    }
    
    @ViewBuilder
    var deviceSettingsView: some View {
        switch device {
        case let .v2(device):
            return DeviceConfigurationViewV2(presenter: .init(device: device, engine: engine))
        case let .v3(device):
            return DeviceConfigurationViewV3(presenter: .init(device: device, engine: engine))
        case let .both(v2: v2, v3: v3):
            return VStack {
                DeviceConfigurationVersionPicker(selectedVersion: $selectedSynapseVersion)
                    .padding()
                
                if selectedSynapseVersion == .v2 {
                    DeviceConfigurationViewV2(presenter: .init(device: v2, engine: engine))
                } else {
                    DeviceConfigurationViewV3(presenter: .init(device: v3, engine: engine))
                }
            }.onAppear(perform: self.loadData)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                CircularButton(text: "✕")
                    { self.onConfigurationClose?() }
                    .padding()
                Spacer()
                if self.engine.persistence.deviceHasStoredData(device) {
                    DestructiveButton(text: "Delete Configuration")
                    { self.isPresentingDeleteAlert = true }
                    .padding()
                }
            }
            deviceSettingsView
        }.alert(isPresented: $isPresentingDeleteAlert) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Do you really wish to delete the saved settings for \"\(self.device.fullName)\"?"),
                primaryButton: .destructive(Text("Yes, I'm sure!"), action: self.deleteDeviceSettings),
                secondaryButton: .cancel(Text("No"))
            )
        }
    }
}

struct DeviceConfigurationView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ForEach(FruityRazer.groupedConnectedDevices, id: \.self) {
                DeviceConfigurationView(device: $0, onConfigurationClose: nil)
            }
        }
    }

}
