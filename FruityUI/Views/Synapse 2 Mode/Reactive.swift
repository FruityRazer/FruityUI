//
//  Reactive.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import ColorPickerRing
import FruityKit
import SwiftUI

struct Reactive: View {
    
    @State var speed: Int
    @State var color: FruityKit.Color?
    
    @Binding var mode: Synapse2Handle.Mode?
    
    init(mode: Binding<Synapse2Handle.Mode?>) {
        self._mode = mode
        
        if let unwrappedMode = mode.wrappedValue, case let Synapse2Handle.Mode.reactive(speed, color) = unwrappedMode {
            self._speed = State(initialValue: speed)
            self._color = State(initialValue: color)
        } else {
            self._speed = State(initialValue: 1)
            self._color = State(initialValue: nil)
        }
    }
    
    private func updateMode() {
        if let color = color {
            mode = .reactive(speed: speed, color: color)
        } else {
            mode = nil
        }
    }
    
    var body: some View {
        let speedFieldBinding = Binding<String>(
            get: { String(self.speed) },
            set: {
                guard let speed = Int($0) else {
                    self.mode = nil
                    
                    return
                }
                
                self.speed = speed
                
                self.updateMode()
            }
        )
        
        let colorBinding = Binding<FruityKit.Color?>(
            get: { self.color },
            set: {
                self.color = $0
                
                self.updateMode()
            }
        )
        
        return VStack {
            GroupBox(label: Text("Speed")) {
                TextField("", text: speedFieldBinding)
            }
            
            GroupBox(label: Text("Color")) {
                CompleteColorPicker(selectedColor: colorBinding)
            }
        }
    }
}

struct Reactive_Previews: PreviewProvider {
    
    static var previews: some View {
        Reactive(mode: .constant(nil))
    }
}
