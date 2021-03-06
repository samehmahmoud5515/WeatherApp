//
//  WeatherForeCastSectionData.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import Foundation

struct WeatherForeCastSectionData {
    let title: String
    let data : [WeatherForeCastUIModel]

    var numberOfItems: Int {
        return data.count
    }

    subscript(index: Int) -> WeatherForeCastUIModel {
        return data[index]
    }
}
