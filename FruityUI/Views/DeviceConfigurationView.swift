//
//  DeviceConfigurationView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

struct DeviceConfigurationView: View {
    var device: RazerDevice!
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Device selected: \(device.fullName)")
                    .padding()
            }.frame(minWidth: 700)
        }
    }
}

struct DeviceConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceConfigurationView()
    }
}
