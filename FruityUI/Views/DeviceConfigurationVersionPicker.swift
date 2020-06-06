//
//  DeviceConfigurationViewMixed.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct DeviceConfigurationVersionPicker: View {
    
    enum SynapseVersion {
        case v2
        case v3
    }
    
    @Binding var selectedVersion: SynapseVersion
    
    var body: some View {
        VStack {
            Picker(selection: $selectedVersion, label: EmptyView()) {
                Text("Synapse 2").tag(SynapseVersion.v2)
                Text("Synapse 3").tag(SynapseVersion.v3)
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct DeviceConfigurationViewMixed_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceConfigurationVersionPicker(selectedVersion: .constant(.v2))
    }
}
