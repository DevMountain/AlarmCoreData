//
//  Alarm+Convenience.swift
//  AlarmCoreData
//
//  Created by Tiffany Sakaguchi on 4/29/21.
//

import Foundation
import CoreData

extension Alarm {
    
    @discardableResult convenience init(title: String, isEnabled: Bool, fireDate: Date, uuidString: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.uuidString = uuidString
        self.isEnabled = isEnabled
        self.fireDate = fireDate
    }
}
