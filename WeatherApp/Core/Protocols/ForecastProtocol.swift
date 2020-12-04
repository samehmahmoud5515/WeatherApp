//
//  ForecastProtocol.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol ForecastProtocol {
    func fetchWeatherForcast(for city: String, completion: ((Result<[Forecast], Error>) -> Void)?)
}

extension ForecastProtocol {
    func fetchWeatherForcast(for city: String, completion: ((Result<[Forecast], Error>) -> Void)?) {
        let service = ForecastService()
        service.fetchWeatherForcast(for: city) { result in
            switch result {
            case let .success(reponse):
                if let forecastList = reponse.list {
                    completion?(.success(forecastList))
                }
            case let .failure(error):
                break
            }
        }
    }
}
