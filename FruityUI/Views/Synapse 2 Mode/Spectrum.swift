//
//  Spectrum.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit
import SwiftUI

struct Spectrum: View {
    
    @Binding var mode: Synapse2Handle.Mode?
    
    var body: some View {
        Text("No settings are required for this mode.")
    }
}

struct Spectrum_Previews: PreviewProvider {
    
    static var previews: some View {
        Spectrum(mode: .constant(.spectrum))
    }
}
