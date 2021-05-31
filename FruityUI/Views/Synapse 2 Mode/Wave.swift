//
//  Wave.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit
import SwiftUI

enum WaveMode: String, CaseIterable {
    
    case left = "Left"
    case right = "Right"
    
    var direction: Direction {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}

struct Wave: View {
    
    let speedSupported: Bool
    
    @State var direction: WaveMode
    @State var speed: Speed
    
    @Binding var mode: Synapse2Handle.Mode?
    
    init(mode: Binding<Synapse2Handle.Mode?>, speedSupported: Bool) {
        self._mode = mode
        self.speedSupported = speedSupported
        
        if let unwrappedMode = mode.wrappedValue, case let Synapse2Handle.Mode.wave(speed, direction) = unwrappedMode {
            self._speed = State(initialValue: speed)
            self._direction = State(initialValue: direction == .right ? .right : .left)
        } else {
            self._speed = State(initialValue: .default)
            self._direction = State(initialValue: .right)
        }
    }
    
    private func updateMode() {
        mode = .wave(speed: speed, direction: direction.direction)
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
        
        let waveModeBinding = Binding<WaveMode>(
            get: { self.direction },
            set: {
                self.direction = $0
                
                self.updateMode()
            }
        )
        
        return VStack {
            if speedSupported {
                GroupBox(label: Text("Speed")) {
                    SpeedSlider(speed: speedBinding)
                }
            }
            
            GroupBox(label: Text("Direction")) {
                Picker(selection: waveModeBinding, label: EmptyView()) {
                    ForEach(WaveMode.allCases, id: \.rawValue) {
                        Text($0.rawValue).tag($0)
                    }
                }
            }
        }
    }
}

struct Wave_Previews: PreviewProvider {
    
    static var previews: some View {
        Wave(mode: .constant(nil), speedSupported: true)
    }
}
