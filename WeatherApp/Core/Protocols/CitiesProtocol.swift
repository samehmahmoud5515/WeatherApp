//
//  CitiesProtocol.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol CitiesProtocol {
    func loadAllCities() -> Cities?
}

extension CitiesProtocol {
    func loadAllCities() -> Cities? {
        return CitiesService().loadAllCities()
    }
}
