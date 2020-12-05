//
//  CitiesSearchResultsProtocols.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

// MARK: View -
protocol CitiesSearchResultsViewProtocol: class {
    func notifiyDataUpdated()
}

// MARK: Presenter -
protocol CitiesSearchResultsPresenterProtocol: CitiesProtocol {
    var view: CitiesSearchResultsViewProtocol? { get set }
    var dataSourceCount: Int { get }
    func viewDidLoad()
    func searchCities(with searchText: String)
    func configure(cell: CitiesSearchResultsCellProtocol, row: Int)
    func didTapOnCell(cell: CitiesSearchResultsCellProtocol, row: Int)
}

protocol CitiesSearchResultsDelegate {
    func didSelectCity(with name: String)
}
