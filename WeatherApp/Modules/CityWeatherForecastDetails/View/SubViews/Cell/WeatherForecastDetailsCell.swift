//
//  WeatherForecastDetailsCell.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import UIKit

protocol WeatherForecastDetailsCellProtcol {
    func updateUI(with title: String, value: String) 
}

class WeatherForecastDetailsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
}

extension WeatherForecastDetailsCell: WeatherForecastDetailsCellProtcol {
    func updateUI(with title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
