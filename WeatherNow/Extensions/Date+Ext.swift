//
//  Date+Ext.swift
//  WeatherNow
//
//  Created by ulas soyubey on 28.05.2022.
//

import Foundation

extension Date {
    static func getCurrentDate()->Date{
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let stringDate = timeFormatter.string(from: time)
        return timeFormatter.date(from: stringDate)!
    }
}
