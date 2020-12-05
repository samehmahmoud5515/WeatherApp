//
//  Date.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

extension Date {
    static let dateTimeFormate = "yyyy-MM-dd HH:mm:ss"
}

extension Date {
    var toDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
