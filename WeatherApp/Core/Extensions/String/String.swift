//
//  String.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

extension String {
    func toDate(with formate: String = Date.dateTimeFormate) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formate
        return dateFormatter.date(from: self)
    }
}
