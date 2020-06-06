//
//  StatusBarMenuController.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit

class StatusBarItemController: NSObject {

    let router: Routable
    
    init(router: Routable, statusBarItem: NSStatusItem) {
        self.router = router
        
        super.init()
    }
    
//    lazy var menu: NSMenu = {
//
//    }()
    
    func buildMenu() -> NSMenu {
        let menu = NSMenu(title: "FruityUI")
        
        menu.addItem(NSMenuItem(title: "Start Engine",
                                action: #selector(startEngine),
                                keyEquivalent: "s"))
        
        menu.addItem(NSMenuItem(title: "Pause Engine",
                                action: #selector(pauseEngine),
                                keyEquivalent: "p"))
        
        menu.addItem(.separator())
        
        menu.addItem(NSMenuItem(title: "Open FruityUI",
                                action: #selector(openFruityUI),
                                keyEquivalent: "o"))
        
        menu.addItem(.separator())
        
        menu.addItem(NSMenuItem(title: "Quit",
                                action: #selector(StatusBarItemController.quit),
                                keyEquivalent: "q"))
        
        return menu;
    }
    
    @objc func startEngine() {
        
    }
    
    @objc func pauseEngine() {
        
    }
    
    @objc func openFruityUI() {
        let keyWindow = NSApplication.shared.keyWindow
        
        if let window = keyWindow {
            window.makeKeyAndOrderFront(nil)
        } else {
            let window = router.openMainWindow()
            
            window.makeKeyAndOrderFront(self)
        }
    }
    
    @objc func quit() {
        NSApp.terminate(nil)
    }
}
