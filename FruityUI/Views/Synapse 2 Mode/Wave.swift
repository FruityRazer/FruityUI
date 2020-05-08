//
//  Wave.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import SwiftUI
import FruityKit

enum WaveMode: String, CaseIterable {
    case left = "Left"
    case right = "Right"
}

struct Wave: View {
    @Binding var direction: WaveMode
    
    var body: some View {
        GroupBox(label: Text("Direction")) {
            Picker(selection: $direction, label: EmptyView()) {
                ForEach(WaveMode.allCases, id: \.rawValue) {
                    Text($0.rawValue).tag($0)
                }
            }
        }
    }
}

struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        Wave(direction: .constant(.right))
    }
}
