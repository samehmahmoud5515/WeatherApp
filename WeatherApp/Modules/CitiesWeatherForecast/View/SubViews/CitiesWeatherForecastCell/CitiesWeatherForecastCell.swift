//
//  CitiesWeatherForecastCell.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import UIKit

protocol CitiesWeatherForecastCellProtocol {
    func updateUI(with title: String)
}

class CitiesWeatherForecastCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
}

extension CitiesWeatherForecastCell: CitiesWeatherForecastCellProtocol {
    func updateUI(with title: String) {
        titleLabel.text = title
    }
}
