//
//  WeatherForeCastUIModel.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import Foundation

struct WeatherForeCastUIModel {
    let title: String
    let value: String
    
    init(_ title: String, value: String) {
        self.title = title
        self.value = value
    }
}
