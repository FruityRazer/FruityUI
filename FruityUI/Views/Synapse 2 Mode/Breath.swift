//
//  Breath.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit
import SwiftUI

struct Breath: View {
    
    @State var color: FruityKit.Color?
    
    @Binding var mode: Synapse2Handle.Mode?
    
    init(mode: Binding<Synapse2Handle.Mode?>) {
        self._mode = mode
        
        if let unwrappedMode = mode.wrappedValue, case let Synapse2Handle.Mode.static(color) = unwrappedMode {
            self._color = State(initialValue: color)
        } else {
            self._color = State(initialValue: nil)
        }
    }
    
    var body: some View {
        let binding = Binding<FruityKit.Color?>(
            get: { self.color },
            set: {
                self.color = $0
                
                if let color = $0 {
                    self.mode = .breath(color: color)
                }
            }
        )
        
        return GroupBox(label: Text("Color")) {
            CompleteColorPicker(selectedColor: binding)
        }
    }
}

struct Breath_Previews: PreviewProvider {
    
    static var previews: some View {
        Breath(mode: .constant(nil))
    }
}
