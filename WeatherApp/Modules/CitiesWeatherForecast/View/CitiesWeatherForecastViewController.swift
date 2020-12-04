//
//  CitiesWeatherForecastViewController.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//

import UIKit

class CitiesWeatherForecastViewController: UIViewController {
    
    //Outlets
    

    //Attribities
	var presenter: CitiesWeatherForecastPresenterProtocol

	init() {
        presenter = CitiesWeatherForecastPresenter()
        super.init(nibName: "\(CitiesWeatherForecastViewController.self)", bundle: nil)
        presenter.view = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

}

extension CitiesWeatherForecastViewController: CitiesWeatherForecastViewProtocol {
    
}
