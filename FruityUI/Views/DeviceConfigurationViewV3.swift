//
//  DeviceConfigurationView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

struct DeviceConfigurationViewV3: View {
    
    @ObservedObject var presenter: DeviceConfigurationViewV3.Presenter
    
    var body: some View {
        let rawConfigurationBinding = Binding<String>(
            get: { self.presenter.rawConfiguration },
            set: { self.presenter.perform(.setRawConfiguration($0)) }
        )
        
        let showingErrorBinding = Binding<Bool>(
            get: { self.presenter.showingError },
            set: { _ in self.presenter.perform(.dismissError) }
        )
        
        return ScrollView {
            VStack {
                Text("Device selected: \(presenter.device.fullName)")
                    .padding()
                GroupBox(label: Text("Raw Data")) {
                    MacEditorTextView(
                        text: rawConfigurationBinding,
                        isEditable: true,
                        font: .userFixedPitchFont(ofSize: 14)
                    )
                    .frame(minWidth: 300,
                           maxWidth: .infinity,
                           minHeight: 200,
                           maxHeight: .infinity)
                }.padding()
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
}

struct DeviceConfigurationViewV3_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceConfigurationViewV3(presenter: .init(device: StubDevice.exampleDevices[0],
                                                   engine: Engine()))
    }
}
