//
//  String+Ext.swift
//  WeatherNow
//
//  Created by ulas soyubey on 28.05.2022.
//

import Foundation

extension String {
    
    func toDate() ->Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: self)
        return date
    }
}
