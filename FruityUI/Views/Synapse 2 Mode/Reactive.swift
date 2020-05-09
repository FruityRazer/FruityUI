//
//  Reactive.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import ColorPicker
import FruityKit
import SwiftUI

struct Reactive: View {
    @State var speedFieldValue: String = "1" {
        didSet {
            speed = Int(speedFieldValue)!
        }
    }
    
    @State var speed: Int = 1 {
        didSet {
            updateMode()
        }
    }
    
    @State var color: FruityKit.Color? = nil {
        didSet {
            updateMode()
        }
    }
    
    @Binding var mode: Synapse2Handle.Mode?
    
    private func updateMode() {
        if let color = color {
            mode = .reactive(speed: speed, color: color)
        } else {
            mode = nil
        }
    }
    
    var body: some View {
        VStack {
            GroupBox(label: Text("Speed")) {
                TextField("", text: $speedFieldValue)
            }
            
            GroupBox(label: Text("Color")) {
                CompleteColorPicker(selectedColor: $color)
            }
        }
    }
}

struct Reactive_Previews: PreviewProvider {
    static var previews: some View {
        Reactive(mode: .constant(nil))
    }
}
