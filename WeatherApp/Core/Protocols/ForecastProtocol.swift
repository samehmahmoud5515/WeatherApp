//
//  ForecastProtocol.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

protocol ForecastProtocol {
    func fetchWeatherForcast(for city: String, completion: ((Result<[Forecast] , Error>) -> Void)?)
}

extension ForecastProtocol {
    func fetchWeatherForcast(for city: String, completion: ((Result<[Forecast] , Error>) -> Void)?) {
        let service = ForecastService()
        service.fetchWeatherForcast(for: city) { result in
            switch result {
            case let .success(reponse):
                if let forecastList = reponse.list {
                    completion?(.success(groupWithDate(forecast: forecastList)))
                }
            case let .failure(error):
                break
            }
        }
    }
    
    private func groupWithDate(forecast: [Forecast]) -> [Forecast] {
        //remove same date measuremnet
        let forcastList = forecast.filterDuplicates(includeElement: { $0.date?.toDateString == $1.date?.toDateString })
        return forcastList
    }
}
