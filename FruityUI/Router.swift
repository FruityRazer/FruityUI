//
//  Router.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit
import SwiftUI

protocol Routable {
    
    @discardableResult
    func openMainWindow() -> NSWindow
}

struct Router: Routable {
    
    let engine: Engine
    
    init(engine: Engine) {
        self.engine = engine
    }
    
    @discardableResult
    func openMainWindow() -> NSWindow {
        let keyWindow = NSApplication.shared.keyWindow
        
        if let window = keyWindow {
            window.makeKeyAndOrderFront(self)
            
            return window
        }
        
        let contentView = ContentView()
            .environmentObject(engine)
        
        let window = ClosableWindow(
            contentRect: NSRect(x: 0, y: 0, width: 960, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false
        )
        
        window.center()
        window.title = "FruityUI for FruityRazer"
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.level = .statusBar
        window.makeKeyAndOrderFront(nil)
        
        window.makeKeyAndOrderFront(self)
        
        return window;
    }
}
