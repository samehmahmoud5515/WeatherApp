//
//  EnvironmentProtocol.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol EnvironmentProtocol {
    var weatherAPIKey: String { get }
}

extension EnvironmentProtocol {
    var weatherAPIKey: String {
        "cbf0c9921fcd38c5b6abaeecc6ff752a"
    }
    
    var baseUrl: String {
        "api.openweathermap.org/data/2.5/"
    }
}
