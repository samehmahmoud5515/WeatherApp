//
//  CitiesSearchResultsViewController.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//
//

import UIKit

class CitiesSearchResultsViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!

    //Attribites
	var presenter: CitiesSearchResultsPresenterProtocol?

    init(delegate: CitiesSearchResultsDelegate) {
        super.init(nibName: "\(CitiesSearchResultsViewController.self)", bundle: nil)
        presenter = CitiesSearchResultsPresenter(view: self, delegate: delegate)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.viewDidLoad()
    }

}

extension CitiesSearchResultsViewController {
    private func setupUI() {
        registerTableViewCell()
        setupTableViewRowHeight()
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(CitiesSearchResultsCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(CitiesSearchResultsCell.self)")
    }
    
    private func setupTableViewRowHeight() {
        tableView.rowHeight = 44
    }
}

extension CitiesSearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = (searchController.searchBar.text ?? "")
        presenter?.searchCities(with: searchText)
    }
}

extension CitiesSearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSourceCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CitiesSearchResultsCell.self)", for: indexPath) as? CitiesSearchResultsCell ?? CitiesSearchResultsCell()
        presenter?.configure(cell: cell, row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CitiesSearchResultsCell {
            presenter?.didTapOnCell(cell: cell, row: indexPath.row)
        }
    }
}

extension CitiesSearchResultsViewController: CitiesSearchResultsViewProtocol {
    func notifiyDataUpdated() {
        tableView.reloadData()
    }
}
