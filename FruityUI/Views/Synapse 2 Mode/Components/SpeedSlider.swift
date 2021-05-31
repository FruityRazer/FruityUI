//
//  SpeedSlider.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 31/05/2021.
//  Copyright © 2021 Eduardo Almeida. All rights reserved.
//

import SwiftUI

struct SpeedSlider: View {
    
    @Binding var speed: Double
    
    var body: some View {
        HStack {
            Text("🐢")
            Slider(value: $speed, in: 0...8, step: 1)
            Text("🐎")
        }
    }
}

struct SpeedSlider_Previews: PreviewProvider {
    static var previews: some View {
        SpeedSlider(speed: .constant(4))
    }
}
