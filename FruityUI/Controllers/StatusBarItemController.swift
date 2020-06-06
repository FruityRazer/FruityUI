//
//  StatusBarMenuController.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 06/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import AppKit

class StatusBarItemController: NSObject {
    
    private enum MenuItemTitle: String {
        
        case startEngine = "⏯️ Start Engine"
        case pauseEngine = "⏸️ Pause Engine"
        case openMainWindow = "🍎 Open FruityUI"
        case quit = "🛑 Quit"
    }
    
    let engine: Engine
    let router: Routable
    let statusBarItem: NSStatusItem
    
    var menu: NSMenu!
    
    init(engine: Engine, router: Routable, statusBarItem: NSStatusItem) {
        self.engine = engine
        self.router = router
        self.statusBarItem = statusBarItem
        
        super.init()
        
        setupStatusItem()
    }
    
    private func addMenuItemWithCorrectTarget(_ menuItem: NSMenuItem) {
        menuItem.target = self
        
        menu.addItem(menuItem)
    }
    
    func setupStatusItem() {
        menu = NSMenu(title: "FruityUI Status Bar Menu")
        
        let menuItems = [
            NSMenuItem(title: MenuItemTitle.startEngine.rawValue,
                       action: #selector(startEngine(_:)),
                       keyEquivalent: ""),
            NSMenuItem(title: MenuItemTitle.pauseEngine.rawValue,
                       action: #selector(pauseEngine(_:)),
                       keyEquivalent: ""),
            .separator(),
            NSMenuItem(title: MenuItemTitle.openMainWindow.rawValue,
                       action: #selector(openMainWindow),
                       keyEquivalent: ""),
            .separator(),
            NSMenuItem(title: MenuItemTitle.quit.rawValue,
                       action: #selector(quit(_:)),
                       keyEquivalent: "")
        ]
        
        menuItems.forEach(addMenuItemWithCorrectTarget(_:))
        
        statusBarItem.menu = menu
    }
    
    @objc func startEngine(_ sender: Any) {
        engine.deviceController.startUpdating()
    }
    
    @objc func pauseEngine(_ sender: Any) {
        engine.deviceController.pauseUpdates(withPauseType: .lightsOut)
    }
    
    @objc func openMainWindow(_ sender: Any) {
        router.openMainWindow()
    }
    
    @objc func quit(_ sender: Any) {
        NSApp.terminate(nil)
    }
}

extension StatusBarItemController: NSMenuItemValidation {
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        let deviceControllerIsRunning = engine.deviceController.status == .running
        
        switch menuItem.title {
        case MenuItemTitle.startEngine.rawValue:
            return !deviceControllerIsRunning
        case MenuItemTitle.pauseEngine.rawValue:
            return deviceControllerIsRunning
        default:
            return true
        }
    }
}
