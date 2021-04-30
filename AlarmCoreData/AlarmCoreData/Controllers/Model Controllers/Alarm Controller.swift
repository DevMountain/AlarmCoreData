//
//  Alarm Controller.swift
//  AlarmCoreData
//
//  Created by Tiffany Sakaguchi on 4/29/21.
//

import Foundation
import CoreData


class AlarmController: AlarmScheduler {
    
    //MARK: - Properties
    
    static let sharedInstance = AlarmController()
    
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    var alarms: [Alarm] {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    //MARK: - Functions
    
    func createAlarm(withTitle title: String, isEnabled: Bool, fireDate: Date) {
        let alarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        if isEnabled {
            scheduleUserNotification(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        if isEnabled {
            scheduleUserNotification(for: alarm)
        }
        saveToPersistentStore()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        CoreDataStack.saveContext()
    }
    
    func delete(alarm: Alarm) {
        cancelUserNotification(for: alarm)
        CoreDataStack.context.delete(alarm)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        if CoreDataStack.context.hasChanges {
            do {
                try CoreDataStack.context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
    
}//End of class


