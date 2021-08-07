//
//  Notification+FruityUI.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 08/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    //  Custom Notifications
    
    static let killLauncher = Notification.Name("KillFruityUILaunchHelper")
    static let persistenceChanged = Notification.Name("PersistenceChanged")
    
    //  OS Notifications
    
    static let persistentStoreRemoteChangeNotification = Notification.Name("NSPersistentStoreRemoteChangeNotification")
}
