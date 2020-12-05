//
//  CityWeatherForecastDetailsPresenter.swift
//  WeatherApp
//
//  Created sameh on 12/4/20.
//
//

import Foundation

class CityWeatherForecastDetailsPresenter: CityWeatherForecastDetailsPresenterProtocol {

    weak var view: CityWeatherForecastDetailsViewProtocol?
    private var cityName: String
    private var cityForecast: CityForecast?
    private var forecastDatasource = [SectionData]() {
        didSet {
            view?.notifyDataChange()
        }
    }
    
    init(view: CityWeatherForecastDetailsViewProtocol, cityName: String, cityForecast: CityForecast? = nil) {
        self.view = view
        self.cityName = cityName
        self.cityForecast = cityForecast
    }

    func viewDidLoad() {
        setupViewTitle()
        loadCityForecastFromDatabase()
        handleCityForecastInCaseIsEmpty()
        handleCityForecastInCaseNotEmpty()
    }
    
    private func setupViewTitle() {
        view?.setupViewTitle(with: cityName)
    }
    
    private func loadCityForecastFromDatabase() {
        if cityForecast == nil {
            cityForecast = CityForecastDatabaseService.shared.fetch(with: cityName)
        }
    }
    
    private func handleCityForecastInCaseIsEmpty() {
        if cityForecast == nil {
            view?.setupAddRightBarButtonItem()
            view?.startActivityIndicator()
            fetchWeatherForecast()
        }
    }
    
    private func handleCityForecastInCaseNotEmpty() {
        if cityForecast != nil {
            buildDatasource(forecastList: cityForecast?.list ?? [])
            view?.setupDeleteRightBarButtonItem()
        }
    }
    
    private func fetchWeatherForecast() {
        fetchWeatherForcast(for: cityName) { [weak self] result in
            switch result {
            case let .success(forecast):
                self?.buildDatasource(forecastList: forecast.list ?? [])
                self?.cityForecast = forecast
            case let .failure(error):
                print(error)
            }
            self?.view?.stopActivityIndicator()
        }
    }
    
    private func buildDatasource(forecastList: [Forecast]) {
        let sectionData = forecastList.map { SectionData(title: $0.date?.toDateString ?? "", data: buidWeatherForecastFromForcast(forcast: $0)) }
        forecastDatasource = sectionData
    }
    
    private func buidWeatherForecastFromForcast(forcast: Forecast) -> [WeatherForeCastUIModel] {
        return [WeatherForeCastUIModel("Min Temp", value: "\(forcast.main?.tempMin ?? 0.0)"),
                WeatherForeCastUIModel("max Temp", value: "\(forcast.main?.tempMax ?? 0.0)"),
                WeatherForeCastUIModel("humidityp", value: "\(forcast.main?.humidity ?? 0)"),
                WeatherForeCastUIModel("pressure", value: "\(forcast.main?.pressure ?? 0)"),
                //WeatherForeCastUIModel("seaLevel", value: "\(forcast.main?. ?? 0)"),
        ]
    }
}

extension CityWeatherForecastDetailsPresenter {
    var sectionsCount: Int {
        return forecastDatasource.count
    }
    
    func numberOftItemsInSection(section: Int) -> Int {
        return forecastDatasource[section].numberOfItems
    }
    
    func title(for section: Int) -> String {
        return forecastDatasource[section].title
    }
    
    func configureCell(cell: WeatherForecastDetailsCellProtcol, with indexPath: IndexPath) {
        cell.updateUI(with: forecastDatasource[indexPath.section].data[indexPath.row].title, value: forecastDatasource[indexPath.section].data[indexPath.row].value)
    }
    
    func saveCityForecast() {
        if let cityForecast = cityForecast {
            CityForecastDatabaseService.shared.save(cityForecast: cityForecast)
            view?.setupDeleteRightBarButtonItem()
        }
    }
    
    func deleteCityForecast() {
        if let city = cityForecast?.city?.name {
            CityForecastDatabaseService.shared.delete(with: city)
            view?.setupAddRightBarButtonItem()
        }
    }
}
