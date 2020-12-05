//
//  CityWeatherForecastDetailsProtcols.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import Foundation

// MARK: View -
protocol CityWeatherForecastDetailsViewProtocol: class {
    func notifyDataChange()
    func stopActivityIndicator()
    func startActivityIndicator()
    func setupAddRightBarButtonItem() 
    func setupDeleteRightBarButtonItem()
}

// MARK: Presenter -
protocol CityWeatherForecastDetailsPresenterProtocol: ForecastProtocol {
    var view: CityWeatherForecastDetailsViewProtocol? { get set }
    var sectionsCount: Int { get }
    func numberOftItemsInSection(section: Int) -> Int
    func title(for section: Int) -> String
    func configureCell(cell: WeatherForecastDetailsCellProtcol, with indexPath: IndexPath)
    func viewDidLoad()
    func saveCityForecast()
    func deleteCityForecast()
}
