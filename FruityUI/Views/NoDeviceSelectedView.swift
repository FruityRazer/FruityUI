//
//  NoDeviceSelectedView.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 22/04/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct NoDeviceSelectedView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Image("FruityUI")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 25)
            Text("FruityUI")
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("(Unofficial) Razer drivers for macOS")
                .font(.caption)
            Text("Choose an entry from the list on your left to start customizing your devices!")
                .font(.footnote)
                .padding(.top, 50)
            Spacer()
        }.frame(minWidth: 700)
    }
}

struct NoDeviceSelectedView_Previews: PreviewProvider {
    
    static var previews: some View {
        NoDeviceSelectedView()
    }
}
