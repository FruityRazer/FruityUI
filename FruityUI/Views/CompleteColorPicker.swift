//
//  CompleteColorPicker.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import ColorPicker
import FruityKit
import SwiftUI

struct CompleteColorPicker: View {
    enum ColorPickerSelection: String, CaseIterable {
        case white = "White"
        case black = "Black"
        case custom = "Custom"
    }
    
    @State var selection: ColorPickerSelection = .white
    @State var customColorSelection: NSColor = .red
    
    @Binding var selectedColor: FruityKit.Color?
    
    var body: some View {
        VStack {
            Picker(selection: self.$selection, label: EmptyView()) {
                ForEach(ColorPickerSelection.allCases, id: \.rawValue) {
                    Text($0.rawValue).tag($0)
                }
            }
            
            if selection == .custom {
                ColorPicker(color: self.$customColorSelection, strokeWidth: 30)
                    .frame(width: 300, height: 300, alignment: .center)
            }
        }
    }
}

struct CompleteColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        CompleteColorPicker(selectedColor: .constant(nil))
    }
}
