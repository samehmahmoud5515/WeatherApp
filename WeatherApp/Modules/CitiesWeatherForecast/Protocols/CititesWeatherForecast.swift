//
//  CititesWeatherForecast.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

// MARK: View -
protocol CitiesWeatherForecastViewProtocol: class {

}

// MARK: Presenter -
protocol CitiesWeatherForecastPresenterProtocol: ForecastProtocol {
    var view: CitiesWeatherForecastViewProtocol? { get set }
    func viewDidLoad()
}
