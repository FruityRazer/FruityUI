//
//  ContentView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 19/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

struct ContentView: View {
    @State private var selectedDevice: RazerDevice?
    
    var body: some View {
        NavigationView {
            DeviceList(selectedDevice: $selectedDevice)
            
            if selectedDevice != nil {
                Text("Hello world!")
            }
        }
        .frame(minWidth: 700, minHeight: 300)
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
