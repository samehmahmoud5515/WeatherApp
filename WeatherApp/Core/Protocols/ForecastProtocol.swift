//
//  ForecastProtocol.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation
import CoreData
import UIKit

protocol ForecastProtocol {
    func fetchWeatherForcast(for city: String, completion: ((Result<CityForecast, Error>) -> Void)?)
}

extension ForecastProtocol {
    func fetchWeatherForcast(for city: String, completion: ((Result<CityForecast, Error>) -> Void)?) {
        let service = ForecastService()
        service.fetchWeatherForcast(for: city) { result in
            switch result {
            case let .success(reponse):
                if let forecastList = reponse.list {
                    var updatedForecast = reponse
                    updatedForecast.list = groupWithDate(forecast: forecastList)
                    completion?(.success(updatedForecast))
                }
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
    
    private func groupWithDate(forecast: [Forecast]) -> [Forecast] {
        //remove same date measuremnet
        let forcastList = forecast.filterDuplicates(includeElement: { $0.date?.toDateString == $1.date?.toDateString })
        return forcastList
    }
}
