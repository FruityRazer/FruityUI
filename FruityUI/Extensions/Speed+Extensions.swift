//
//  Speed+Extensions.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 29/05/2021.
//  Copyright © 2021 Eduardo Almeida. All rights reserved.
//

import FruityKit

extension Speed {
    
    var uiValue: Int {
        switch self {
        case .unacceptablySlow:
            return 0
        case .slowest:
            return 1
        case .slower:
            return 2
        case .slow:
            return 3
        case .default:
            return 4
        case .fast:
            return 5
        case .faster:
            return 6
        case .fastest:
            return 7
        case .unacceptablyFast:
            return 8
        }
    }
    
    init?(fromUIValue value: Int) {
        switch value {
        case 0:
            self = .unacceptablySlow
        case 1:
            self = .slowest
        case 2:
            self = .slower
        case 3:
            self = .slow
        case 4:
            self = .default
        case 5:
            self = .fast
        case 6:
            self = .faster
        case 7:
            self = .fastest
        case 8:
            self = .unacceptablyFast
        default:
            return nil
        }
    }
    
    var stringValue: String {
        switch self {
        case .unacceptablySlow:
            return "Unacceptably Slow"
        case .slowest:
            return "Slowest"
        case .slower:
            return "Slower"
        case .slow:
            return "Slow"
        case .default:
            return "Default"
        case .fast:
            return "Fast"
        case .faster:
            return "Faster"
        case .fastest:
            return "Fastest"
        case .unacceptablyFast:
            return "Unacceptably Fast"
        }
    }
}
