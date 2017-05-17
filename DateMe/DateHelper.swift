//
//  DateHelper.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/17/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation

enum DateHelper {
    
    static var thisMorningAtMidnight: Date? {
        let calendar = Calendar.current
        let now = Date()
        return (calendar as NSCalendar).date(bySettingHour: 0, minute: 0, second: 0, of: now, options: [])
    }
    
    static var tomorrowMorningAtMidnight: Date? {
        let calendar = Calendar.current
        guard let thisMorningAtMidnight = thisMorningAtMidnight else { return nil }
        return (calendar as NSCalendar).date(byAdding: .day, value: 1, to: thisMorningAtMidnight, options: [])
    }
}
