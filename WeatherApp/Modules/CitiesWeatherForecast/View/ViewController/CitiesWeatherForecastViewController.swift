//
//  CitiesWeatherForecastViewController.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//

import UIKit

class CitiesWeatherForecastViewController: UIViewController, CitiesWeatherForecastViewProtocol {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!

    //Attribities
	var presenter: CitiesWeatherForecastPresenterProtocol?

	init() {
        super.init(nibName: "\(CitiesWeatherForecastViewController.self)", bundle: nil)
        presenter = CitiesWeatherForecastPresenter(view: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        setupUI()
    }

}

// MARK:- UI Setup
extension CitiesWeatherForecastViewController {
    private func setupUI() {
        addSearchController()
    }
    
    private func addSearchController() {
        let searchResultsVc = CitiesSearchResultsViewController(delegate: self)
        let searchController = UISearchController(searchResultsController: searchResultsVc)
        searchController.searchResultsUpdater = searchResultsVc
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search artists"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension CitiesWeatherForecastViewController: CitiesSearchResultsDelegate {
    func didSelectCity(with name: String) {
        navigationItem.searchController?.searchResultsController?.dismiss(animated: true, completion: { [weak self] in
            let vc = CityWeatherForecastDetailsViewController(cityName: name)
            self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
