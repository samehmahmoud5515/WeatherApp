//
//  CityWeatherForecastDetailsViewController.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//
//

import UIKit

class CityWeatherForecastDetailsViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // Attribuites
	var presenter: CityWeatherForecastDetailsPresenterProtocol?

    init(cityName: String) {
        super.init(nibName: "\(CityWeatherForecastDetailsViewController.self)", bundle: nil)
        self.presenter = CityWeatherForecastDetailsPresenter(view: self, cityName: cityName)
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

extension CityWeatherForecastDetailsViewController {
    private func setupUI() {
        registerTableViewCell()
        setupTableViewRowHeight()
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(WeatherForecastDetailsCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(WeatherForecastDetailsCell.self)")
    }
    
    private func setupTableViewRowHeight() {
        tableView.rowHeight = 44
    }
}

extension CityWeatherForecastDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOftItemsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WeatherForecastDetailsCell.self)", for: indexPath) as? WeatherForecastDetailsCell ?? WeatherForecastDetailsCell()
        presenter?.configureCell(cell: cell, with: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.sectionsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.title(for: section) ?? ""
    }
}

extension CityWeatherForecastDetailsViewController: CityWeatherForecastDetailsViewProtocol {
    func notifyDataChange() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func startActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
