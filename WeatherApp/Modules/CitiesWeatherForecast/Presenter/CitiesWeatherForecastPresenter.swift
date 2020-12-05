//
//  CitiesWeatherForecastPresenter.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//
//

import Foundation
import CoreLocation

class CitiesWeatherForecastPresenter: CitiesWeatherForecastPresenterProtocol {
    
    //Constant
    let defaultCity = "London"
    
    //Attribuites
    weak var view: CitiesWeatherForecastViewProtocol?
    
    lazy var locationProvider: UserLocationService = {
        UserLocationService()
    }()
    
    var citiesForecasts = [CityForecast]() {
        didSet {
            view?.notifiyDataChanging()
        }
    }
    
    init(view: CitiesWeatherForecastViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        requestUserLocation()
    }
    
    func requestUserLocation() {
        locationProvider.findUserLocation { [weak self] result in
            switch result {
            case let .success(coordinate):
                self?.reverseUserLocation(location: coordinate)
            case let .failure(error):
                print(error)
                self?.citiesForecasts.append(CityForecast(city: City(name: self?.defaultCity ?? "")))
            }
        }
    }
    
    func reverseUserLocation(location: Coordinate) {
        locationProvider.reverseGeocodeToCountry(coordinate: location) { [weak self] result in
            switch result {
            case let .success(city):
                print(city)
                if !(self?.citiesForecasts.contains(where: { $0.city?.name == city }) ?? true) {
                    self?.citiesForecasts.append(CityForecast(city: City(name: city)))
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    var numberOfItemsInDatasource: Int {
        return citiesForecasts.count
    }
    
    func configureCell(cell: CitiesWeatherForecastCellProtocol, with row: Int) {
        cell.updateUI(with: citiesForecasts[row].city?.name ?? "")
    }
    
    func didSelectCell(at row: Int) {
        let cityForecast = citiesForecasts[row]
        if cityForecast.list == nil, let name = cityForecast.city?.name {
            view?.navigateToCityForecast(with: name)
        }
    }
    
}
