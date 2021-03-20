//
//  NoDeviceSelectedView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct NoDeviceSelectedView: View {
    
    @State var automaticallyCheckForUpdates: Bool = false
    @State var openAtLogin: Bool = false
    
    @EnvironmentObject var engine: Engine
    
    func updatePreferencesState() {
        self.automaticallyCheckForUpdates = engine.updateManager.automaticallyCheckForUpdates
        self.openAtLogin = engine.loginItemManager.openAtLogin
    }
    
    var body: some View {
        return VStack {
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
                    
                    VStack {
                        Spacer()
                        
                        Toggle(isOn: $automaticallyCheckForUpdates) {
                            Text("Automatically Check for Updates")
                                .onTapGesture {
                                    self.engine.updateManager.automaticallyCheckForUpdates.toggle()
                                    self.updatePreferencesState()
                                }
                        }.padding()
                        
                        Toggle(isOn: $openAtLogin) {
                            Text("Open at Login")
                                .onTapGesture {
                                    self.engine.loginItemManager.toggle()
                                    self.updatePreferencesState()
                                }
                        }.padding()
                        
                        Spacer()
                        
                        Button("Check for Updates") {
                            self.engine.updateManager.checkForUpdates()
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
            Spacer()
        }
        .frame(minWidth: 700)
        .onAppear(perform: self.updatePreferencesState)
    }
}

struct NoDeviceSelectedView_Previews: PreviewProvider {
    
    static var previews: some View {
        NoDeviceSelectedView()
    }
}
