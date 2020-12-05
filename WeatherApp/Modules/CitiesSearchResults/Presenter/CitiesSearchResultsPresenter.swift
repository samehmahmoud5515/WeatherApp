//
//  CitiesSearchResultsPresenter.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//
//

import Foundation

class CitiesSearchResultsPresenter: CitiesSearchResultsPresenterProtocol {

    weak var view: CitiesSearchResultsViewProtocol?
    var delegate: CitiesSearchResultsDelegate?

    var allCities = [String]()
    var filteredCities = [String]() {
        didSet {
            view?.notifiyDataUpdated()
        }
    }
    
    init(view: CitiesSearchResultsViewProtocol, delegate: CitiesSearchResultsDelegate) {
        self.view = view
        self.delegate = delegate
    }

    func viewDidLoad() {
        allCities = loadAllCities() ?? []
    }
}

extension CitiesSearchResultsPresenter {
    
    var dataSourceCount: Int {
        filteredCities.count
    }
    
    func searchCities(with searchText: String) {
        filteredCities = allCities.filter { $0.contains(searchText) }
    }
    
    func configure(cell: CitiesSearchResultsCellProtocol, row: Int) {
        let city = filteredCities[row]
        cell.updateUIWith(name: city)
    }
    
    func didTapOnCell(cell: CitiesSearchResultsCellProtocol, row: Int) {
        delegate?.didSelectCity(with: filteredCities[row])
    }
}
