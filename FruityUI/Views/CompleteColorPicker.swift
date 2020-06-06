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
    
    func syncColorSelection() {
        self.selectedColor = FruityKit.Color(red: UInt8(self.customColorSelection.redComponent * 255),
                                             green: UInt8(self.customColorSelection.greenComponent * 255),
                                             blue: UInt8(self.customColorSelection.blueComponent * 255))
    }
    
    var body: some View {
        let pickerSelectionBinding = Binding<ColorPickerSelection>(
            get: { self.selection },
            set: {
                self.selection = $0
                
                switch $0 {
                case .white:
                    self.selectedColor = FruityKit.Color(red: 255, green: 255, blue: 255)
                case .black:
                    self.selectedColor = FruityKit.Color(red: 0, green: 0, blue: 0)
                case .custom:
                    self.syncColorSelection()
                }
            }
        )
        
        let customColorBinding = Binding<NSColor>(
            get: { self.customColorSelection },
            set: {
                self.customColorSelection = $0
                
                self.syncColorSelection()
            }
        )
        
        return VStack {
            Picker(selection: pickerSelectionBinding, label: EmptyView()) {
                ForEach(ColorPickerSelection.allCases, id: \.rawValue) {
                    Text($0.rawValue).tag($0)
                }
            }
            
            if selection == .custom {
                ColorPicker(color: customColorBinding, strokeWidth: 30)
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding()
            }
        }
    }
}

struct CompleteColorPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        CompleteColorPicker(selectedColor: .constant(nil))
    }
}
