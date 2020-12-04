//
//  CitiesSearchResultsCell.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import UIKit

protocol CitiesSearchResultsCellProtocol: class {
    func updateUIWith(name: String)
}


class CitiesSearchResultsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension CitiesSearchResultsCell: CitiesSearchResultsCellProtocol {
    func updateUIWith(name: String) {
        titleLabel.text = name
    }
}
