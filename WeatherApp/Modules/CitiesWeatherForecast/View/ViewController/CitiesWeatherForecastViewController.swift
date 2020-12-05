//
//  CitiesWeatherForecastViewController.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//

import UIKit

class CitiesWeatherForecastViewController: UIViewController {
    
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
        registerTableViewCell()
        setupTableViewRowHeight()
    }
    
    private func addSearchController() {
        let searchResultsVc = CitiesSearchResultsViewController(delegate: self)
        let searchController = UISearchController(searchResultsController: searchResultsVc)
        searchController.searchResultsUpdater = searchResultsVc
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(CitiesWeatherForecastCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(CitiesWeatherForecastCell.self)")
    }
    
    private func setupTableViewRowHeight() {
        tableView.rowHeight = 44
    }
}

// MARK: - CitiesSearchResultsDelegate
extension CitiesWeatherForecastViewController: CitiesSearchResultsDelegate {
    func didSelectCity(with name: String) {
        navigationItem.searchController?.searchResultsController?.dismiss(animated: true, completion: { [weak self] in
            let vc = CityWeatherForecastDetailsViewController(cityName: name)
            self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
 
// MARK: - UITableViewDataSource - UITableViewDelegate
extension CitiesWeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInDatasource ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CitiesWeatherForecastCell.self)", for: indexPath) as? CitiesWeatherForecastCell ?? CitiesWeatherForecastCell()
        presenter?.configureCell(cell: cell, with: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath.row)
    }
}

// MARK:- CitiesWeatherForecastViewProtocol
extension CitiesWeatherForecastViewController: CitiesWeatherForecastViewProtocol {
    func notifiyDataChanging() {
        tableView.reloadData()
    }
    
    func navigateToCityForecast(with cityName: String) {
        let vc = CityWeatherForecastDetailsViewController(cityName: cityName)
        navigationController?.pushViewController(vc, animated: true)
    }
}

