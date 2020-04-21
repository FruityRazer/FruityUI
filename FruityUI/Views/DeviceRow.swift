//
//  DeviceRow.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 21/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

protocol Device {
    var shortName: String { get }
    var fullName: String { get }
    var connected: Bool { get }
}

extension RazerDevice: Device {}

struct DeviceRow: View {
    let device: Device
    
    var body: some View {
        HStack(alignment: .center) {
            Rectangle()
                .size(width: 50, height: 50)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(device.fullName)
                    .font(.subheadline)
                Text(device.connected ? "Connected" : "Disconnected")
                    .font(.caption)
                    .foregroundColor(device.connected ? .green : .red)
            }
        }
    }
}

struct DeviceRow_Previews: PreviewProvider {
    struct StubDevice: Device {
        let shortName: String
        let fullName: String
        let connected: Bool
    }
    
    static var previews: some View {
        Group {
            DeviceRow(device: StubDevice(shortName: "huntsman_elite", fullName: "Razer Huntsman Elite", connected: true))
            DeviceRow(device: StubDevice(shortName: "lycosa", fullName: "Razer Lycosa", connected: false))
        }
    }
}
