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
    let statusBarItem: NSStatusItem
    
    var menu: NSMenu?
    
    init(router: Routable, statusBarItem: NSStatusItem) {
        self.router = router
        self.statusBarItem = statusBarItem
        
        super.init()
        
        setup()
    }
    
    func setup() {
        menu = NSMenu(title: "FruityUI")
        
        menu!.addItem(NSMenuItem(title: "⏯️ Start Engine",
                                 action: #selector(startEngine),
                                 keyEquivalent: ""))
        
        menu!.addItem(NSMenuItem(title: "⏸️ Pause Engine",
                                 action: #selector(pauseEngine),
                                 keyEquivalent: ""))
        
        menu!.addItem(.separator())
        
        menu!.addItem(NSMenuItem(title: "🍎 Open FruityUI",
                                 action: #selector(openFruityUI),
                                 keyEquivalent: ""))
        
        menu!.addItem(.separator())
        
        menu!.addItem(NSMenuItem(title: "🛑 Quit",
                                 action: #selector(StatusBarItemController.quit),
                                 keyEquivalent: ""))
        
        statusBarItem.menu = menu
    }
    
    @objc func startEngine() {
        
    }
    
    @objc func pauseEngine() {
        
    }
    
    @objc func openFruityUI() {
        router.openMainWindow()
    }
    
    @objc func quit() {
        NSApp.terminate(nil)
    }
}
