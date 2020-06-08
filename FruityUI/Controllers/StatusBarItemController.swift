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
        
        case startEngine = "▶ Start Engine"
        case pauseEngine = "■ Pause Engine"
        case forceReSync = "↻ Force Re-Sync"
        case preferences = "Preferences"
        case openMainWindow = "Open FruityUI"
        case openAtLogin = "Open at Login"
        case quit = "Quit"
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
    
    private var preferencesSubMenuItem: NSMenuItem {
        let preferencesSubMenuItem = NSMenuItem(title: MenuItemTitle.preferences.rawValue,
                                                action: nil,
                                                keyEquivalent: "")
        
        let preferencesSubMenu = NSMenu(title: "Preferences Sub Menu")
        
        let preferencesSubMenuItems = [
            NSMenuItem(title: MenuItemTitle.openMainWindow.rawValue,
                       action: #selector(openMainWindow),
                       keyEquivalent: ""),
            .separator(),
            NSMenuItem(title: MenuItemTitle.openAtLogin.rawValue,
                       action: #selector(toggleOpenAtLogin),
                       keyEquivalent: ""),
        ]
        
        preferencesSubMenuItems.forEach {
            $0.target = self
            
            preferencesSubMenu.addItem($0)
        }
        
        preferencesSubMenuItem.submenu = preferencesSubMenu
        
        return preferencesSubMenuItem
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
            NSMenuItem(title: MenuItemTitle.forceReSync.rawValue,
                       action: #selector(forceReSync(_:)),
                       keyEquivalent: ""),
            .separator(),
            preferencesSubMenuItem,
            .separator(),
            NSMenuItem(title: MenuItemTitle.quit.rawValue,
                       action: #selector(quit(_:)),
                       keyEquivalent: "")
        ]
        
        menuItems.forEach(addMenuItemWithCorrectTarget(_:))
        
        statusBarItem.menu = menu
    }
    
    @objc func startEngine(_ sender: Any) {
        engine.deviceController.startUpdates()
    }
    
    @objc func pauseEngine(_ sender: Any) {
        engine.deviceController.pauseUpdates(withPauseType: .lightsOut)
    }
    
    @objc func forceReSync(_ sender: Any) {
        engine.deviceController.forceUpdate()
    }
    
    @objc func openMainWindow(_ sender: Any) {
        router.openMainWindow()
    }
    
    @objc func toggleOpenAtLogin(_ sender: Any) {
        engine.loginItemManager.toggle()
    }
    
    @objc func quit(_ sender: Any) {
        NSApp.terminate(nil)
    }
}

extension StatusBarItemController: NSMenuItemValidation {
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        let deviceControllerIsRunning = engine.deviceController.status == .running
        
        switch menuItem.title {
        case MenuItemTitle.forceReSync.rawValue:
            return engine.deviceController.status == .running
            
        case MenuItemTitle.openAtLogin.rawValue:
            menuItem.state = engine.loginItemManager.openAtLogin ? .on : .off
            return true
            
        case MenuItemTitle.pauseEngine.rawValue:
            return deviceControllerIsRunning
            
        case MenuItemTitle.startEngine.rawValue:
            return !deviceControllerIsRunning
            
        default:
            return true
        }
    }
}
