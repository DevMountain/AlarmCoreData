//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Tiffany Sakaguchi on 4/29/21.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: AnyObject {
    func scheduleUserNotification(for alarm: Alarm)
    func cancelUserNotification(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Time to get up"
        content.body = "Your alarm named \(alarm.title!) is going off"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.month, .day, .year, .hour, .minute, .second], from:  alarm.fireDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuidString!, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling local user notifications: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotification(for alarm: Alarm) {
        guard let id = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
