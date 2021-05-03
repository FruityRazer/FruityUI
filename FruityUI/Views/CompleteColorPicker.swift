//
//  CompleteColorPicker.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import ColorPickerRing
import FruityKit
import SwiftUI

struct CompleteColorPicker: View {
    
    enum ColorPickerSelection: String, CaseIterable {
        case white = "White"
        case black = "Black"
        case custom = "Custom"
    }
    
    @State var selection: ColorPickerSelection
    @State var customColorSelection: NSColor
    
    @Binding var selectedColor: FruityKit.Color?
    
    init(selectedColor: Binding<FruityKit.Color?>) {
        self._selectedColor = selectedColor
        
        if let color = selectedColor.wrappedValue {
            if color.r == 0 && color.g == 0 && color.b == 0 {
                self._selection = State(initialValue: .black)
                self._customColorSelection = State(initialValue: .red)
            } else if color.r == 255 && color.g == 255 && color.b == 255 {
                self._selection = State(initialValue: .white)
                self._customColorSelection = State(initialValue: .red)
            } else {
                self._selection = State(initialValue: .custom)
                self._customColorSelection = State(initialValue: NSColor(calibratedRed: CGFloat(color.r) / 255,
                                                                         green: CGFloat(color.g) / 255,
                                                                         blue: CGFloat(color.b) / 255.0,
                                                                         alpha: 1))
            }
        } else {
            self._selection = State(initialValue: .white)
            self._customColorSelection = State(initialValue: .red)
        }
    }
    
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
                ColorPickerRing(color: customColorBinding, strokeWidth: 30)
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
