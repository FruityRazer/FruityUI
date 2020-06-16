//
//  DeviceRow.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 21/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import URLImage

struct DeviceRow: View {
    
    let device: Device
    
    var body: some View {
        HStack(alignment: .center) {
            URLImage(device.imageURL) {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
                .frame(width: 50, height: 50, alignment: .trailing)
            VStack(alignment: .leading) {
                Spacer()
                Text(device.fullName)
                    .font(.subheadline)
                HStack {
                    Circle()
                        .fill(device.connected ? Color.green : Color.red)
                        .frame(width: 10, height: 10)
                    Text(device.connected ? "Connected" : "Disconnected")
                        .font(.caption)
                        .foregroundColor(device.connected ? .green : .red)
                }
                Spacer()
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
