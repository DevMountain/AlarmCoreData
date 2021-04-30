//
//  DateFormatter.swift
//  AlarmCoreData
//
//  Created by Tiffany Sakaguchi on 4/29/21.
//

import Foundation


extension DateFormatter {
    static let fireDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
