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
    
    weak var view: CitiesWeatherForecastViewProtocol?
    
    lazy var locationProvider: UserLocationProvider = {
        UserLocationService()
    }()
    
    init(view: CitiesWeatherForecastViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        requestUserLocation()
    }
    
    func requestUserLocation() {
        locationProvider.findUserLocation { [weak self] location, error in
            if let location = location?.coordinate {
                self?.reverseUserLocation(location: location)
            } else {
                
            }
        }
    }
    
    func reverseUserLocation(location: Coordinate) {
        
    }
    
}
