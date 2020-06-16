//
//  NoDeviceSelectedView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct NoDeviceSelectedView: View {
    
    @EnvironmentObject var engine: Engine
    
    @State var openAtLoginToggleState: Bool = false
    
    func onAppear() {
        self.openAtLoginToggleState = engine.loginItemManager.openAtLogin
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                CircularButton(text: "?")
                    { NSWorkspace.shared.open(URLs.help) }
                    .padding()
            }
            Spacer()
            
            Image("FruityUI")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 25)
            HStack(alignment: .top) {
                Text("FruityUI")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                
                PillButton(text: "\(Bundle.main.shortVersion) (\(Bundle.main.version))")
                    { NSWorkspace.shared.open(URLs.releases) }
            }
            Text("(Unofficial) Razer drivers for macOS")
                .font(.caption)
            Text("Choose an entry from the list on your left to start customizing your devices!")
                .font(.footnote)
                .padding(.top, 50)
            
            Spacer()
            
            GroupBox(label: Text("Preferences")) {
                HStack {
                    Spacer()
                    Toggle(isOn: $openAtLoginToggleState) {
                        Text("Open at Login")
                    }.onReceive([self.openAtLoginToggleState].publisher.first()) { _ in
                        self.engine.loginItemManager.toggle()
                    }.padding()
                    Spacer()
                }
            }
                .padding()
            
            Spacer()
        }
            .onAppear(perform: self.onAppear)
            .frame(minWidth: 700)
    }
}

struct NoDeviceSelectedView_Previews: PreviewProvider {
    
    static var previews: some View {
        NoDeviceSelectedView()
    }
}
