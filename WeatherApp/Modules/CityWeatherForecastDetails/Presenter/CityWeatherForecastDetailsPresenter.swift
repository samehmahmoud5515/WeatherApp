//
//  CityWeatherForecastDetailsPresenter.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//
//

import Foundation

// MARK: View -
protocol CityWeatherForecastDetailsViewProtocol: class {

}

// MARK: Presenter -
protocol CityWeatherForecastDetailsPresenterProtocol: class {
	var view: CityWeatherForecastDetailsViewProtocol? { get set }
    func viewDidLoad()
}

class CityWeatherForecastDetailsPresenter: CityWeatherForecastDetailsPresenterProtocol {

    weak var view: CityWeatherForecastDetailsViewProtocol?
    
    init(view: CityWeatherForecastDetailsViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {

    }
}
