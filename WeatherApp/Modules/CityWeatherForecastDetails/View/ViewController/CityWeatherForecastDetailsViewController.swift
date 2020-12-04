//
//  CityWeatherForecastDetailsViewController.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//
//

import UIKit

class CityWeatherForecastDetailsViewController: UIViewController, CityWeatherForecastDetailsViewProtocol {

	var presenter: CityWeatherForecastDetailsPresenterProtocol?

	init() {
        super.init(nibName: "\(CityWeatherForecastDetailsViewController.self)", bundle: nil)
        self.presenter = CityWeatherForecastDetailsPresenter(view: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

}
