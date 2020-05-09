//
//  Static.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit
import SwiftUI

struct Static: View {
    @State var color: FruityKit.Color? = nil {
        didSet {
            if let color = color {
                mode = .static(color: color)
            }
        }
    }
    
    @Binding var mode: Synapse2Handle.Mode?
    
    var body: some View {
        GroupBox(label: Text("Color")) {
            CompleteColorPicker(selectedColor: $color)
        }
    }
}

struct Static_Previews: PreviewProvider {
    static var previews: some View {
        Static(mode: .constant(nil))
    }
}
