//
//  ForecastService.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

class ForecastService: APIService<ForecastEndpoint> {
    func fetchWeatherForcast(for city: String, completion: ((Result<ForecastResponse, Error>) -> Void)?) {
        sendRequest(target: .forecast(city: city), completion: completion)
    }
}
