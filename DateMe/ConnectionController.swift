//
//  ConnectionController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/17/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import UserNotifications

class ConnectionController {
    
    static let shared = ConnectionController()
    
    var connections: [Connection] = []
    
    
    
    
    
    
    //==============================================================
    // MARK: - Time Interval Functions
    //==============================================================
    static private var persistentConnectionFilePath: String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Disconnect.plist")
    }
    
    private func saveToPersistentStore() {
        guard let filePath = type(of: self).persistentConnectionFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.connections, toFile: filePath)
    }
    
    func loadFromPersistentStore() {
        guard let filePath = type(of: self).persistentConnectionFilePath else { return }
        guard let connections = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Connection] else { return }
        self.connections = connections
        print("loadFromPersistentStore")
    }
}

protocol DisconnectScheduler {
    func scheduleLocalNotification(for connection: Connection)
    func cancelLocalNotification(for connection: Connection)
}

extension DisconnectScheduler {
    func scheduleLocalNotification(for connection: Connection) {
        print("lslsls")
        let notificationContent = UNMutableNotificationContent()
        notificationContent.userInfo = ["UUID" : connection.uuid]
        notificationContent.title = "Missed out on a connection"
        notificationContent.body = "You lost a connection!"
        notificationContent.sound = UNNotificationSound.default()
        
        guard let fireDate = connection.fireDate else { return }
        let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(identifier: connection.uuid, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable notification, \(error.localizedDescription)")
            }
        }
    }
    
    func cancelLocalNotification(for connection: Connection) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [connection.uuid])
    }
}














