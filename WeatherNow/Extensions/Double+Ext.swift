//
//  Double+Ext.swift
//  WeatherNow
//
//  Created by ulas soyubey on 26.05.2022.
//

import Foundation

extension Double {
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
