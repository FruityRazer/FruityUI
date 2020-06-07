//
//  Color+Hex.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 07/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import FruityKit

extension Color {
    
    var hexValue: String {
        String(format: "#%06x", Int(r) << 16 | Int(g) << 8 | Int(b))
    }
}
