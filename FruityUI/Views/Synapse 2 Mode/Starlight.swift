//
//  Starlight.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 14/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import ColorPickerRing
import FruityKit
import SwiftUI

struct Starlight: View {
    
    @State var speed: Speed
    @State var color1: FruityKit.Color?
    @State var color2: FruityKit.Color?
    
    @Binding var mode: Synapse2Handle.Mode?
    
    init(mode: Binding<Synapse2Handle.Mode?>) {
        self._mode = mode
        
        if let unwrappedMode = mode.wrappedValue, case let Synapse2Handle.Mode.starlight(speed, color1, color2) = unwrappedMode {
            self._speed = State(initialValue: speed)
            self._color1 = State(initialValue: color1)
            self._color2 = State(initialValue: color2)
        } else {
            self._speed = State(initialValue: .default)
            self._color1 = State(initialValue: nil)
            self._color2 = State(initialValue: nil)
        }
    }
    
    private func updateMode() {
        if let color1 = color1, let color2 = color2 {
            mode = .starlight(speed: speed, color1: color1, color2: color2)
        } else {
            mode = nil
        }
    }
    
    var body: some View {
        let speedBinding = Binding<Double>(
            get: { Double(self.speed.uiValue) },
            set: {
                guard let speed = Speed(fromUIValue: Int($0)) else {
                    assertionFailure("Speed value out of bounds.")
                    
                    return
                }
                
                self.speed = speed
                
                self.updateMode()
            }
        )
        
        let color1Binding = Binding<FruityKit.Color?>(
            get: { self.color1 },
            set: {
                self.color1 = $0
                
                self.updateMode()
            }
        )
        
        let color2Binding = Binding<FruityKit.Color?>(
            get: { self.color2 },
            set: {
                self.color2 = $0
                
                self.updateMode()
            }
        )
        
        return VStack {
            GroupBox(label: Text("Speed")) {
                Slider(value: speedBinding, in: 0...8, step: 1) { Text("Speed") }
            }
            
            GroupBox(label: Text("Color (1)")) {
                CompleteColorPicker(selectedColor: color1Binding)
            }
            
            GroupBox(label: Text("Color (2)")) {
                CompleteColorPicker(selectedColor: color2Binding)
            }
        }
    }
}

struct Starlight_Previews: PreviewProvider {
    
    static var previews: some View {
        Starlight(mode: .constant(nil))
    }
}
