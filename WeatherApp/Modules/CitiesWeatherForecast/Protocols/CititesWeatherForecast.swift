//
//  CititesWeatherForecast.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

// MARK: View -
protocol CitiesWeatherForecastViewProtocol: class {
    func notifiyDataChanging()
    func navigateToCityForecast(with cityName: String)
    func navigateToCityForecast(with cityName: String, cityForecast: CityForecast)
}

// MARK: Presenter -
protocol CitiesWeatherForecastPresenterProtocol: ForecastProtocol {
    var view: CitiesWeatherForecastViewProtocol? { get set }
    func viewDidLoad()
    var numberOfItemsInDatasource: Int { get }
    func configureCell(cell: CitiesWeatherForecastCellProtocol, with row: Int)
    func didSelectCell(at row: Int)
    func didDeleteCell(at index: Int) 
    func fetchAllCitiesForecasts()
}
