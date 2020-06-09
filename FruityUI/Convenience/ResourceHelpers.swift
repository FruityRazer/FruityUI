//
//  ResourceHelpers.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit

enum ResourceHelpers {
    
    static var statusBarImage: NSImage {
        let newSize = NSSize(width: 20, height: 20)
        
        let sourceImage = NSImage(named: "SnakeTemplate")
        
        let newImage = NSImage(size: newSize)
        newImage.lockFocus()
        
        sourceImage?.size = newSize
        
        NSGraphicsContext.current?.imageInterpolation = .high
        
        sourceImage?.draw(at: .zero, from: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height), operation: .copy, fraction: 1.0)
        
        newImage.unlockFocus()
        
        newImage.isTemplate = true
        
        return newImage
    }
}
