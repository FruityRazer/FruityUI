//
//  DeviceRow.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 21/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct DeviceRow: View {
    let device: Device
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: device.imageURL, placeholder: Rectangle().frame(width: 50, height: 50, alignment: .trailing), configuration: { $0.resizable() })
                .frame(width: 50, height: 50, alignment: .trailing)
            
            VStack(alignment: .leading) {
                Text(device.fullName)
                    .font(.subheadline)
                HStack {
                    //  Add some sort of traffic light image here...
                    Text(device.connected ? "Connected" : "Disconnected")
                        .font(.caption)
                        .foregroundColor(device.connected ? .green : .red)
                }
            }
        }
    }
}

struct DeviceRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(StubDevice.exampleDevices, id: \.shortName) {
                DeviceRow(device: $0)
            }
        }
    }
}
