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
    
    let speedSupported: Bool
    
    @State var speed: Speed
    @State var color: FruityKit.Color?
    
    @Binding var mode: Synapse2Handle.Mode?
    
    init(mode: Binding<Synapse2Handle.Mode?>, speedSupported: Bool) {
        self._mode = mode
        self.speedSupported = speedSupported
        
        if let unwrappedMode = mode.wrappedValue, case let Synapse2Handle.Mode.reactive(speed, color) = unwrappedMode {
            self._speed = State(initialValue: speed)
            self._color = State(initialValue: color)
        } else {
            self._speed = State(initialValue: .default)
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
        
        let colorBinding = Binding<FruityKit.Color?>(
            get: { self.color },
            set: {
                self.color = $0
                
                self.updateMode()
            }
        )
        
        return VStack {
            if speedSupported {
                GroupBox(label: Text("Speed")) {
                    SpeedSlider(speed: speedBinding)
                }
            }
            
            GroupBox(label: Text("Color")) {
                CompleteColorPicker(selectedColor: colorBinding)
            }
        }
    }
}

struct Reactive_Previews: PreviewProvider {
    
    static var previews: some View {
        Reactive(mode: .constant(nil), speedSupported: true)
    }
}
