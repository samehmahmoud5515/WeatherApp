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
    private var forecastDatasource = [WeatherForeCastSectionData]() {
        didSet {
            view?.notifyDataChange()
        }
    }
    private let localizer = CityWeatherForecastDetailsLocalizer()
    
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
        view?.startActivityIndicator()
        fetchWeatherForcast(for: cityName) { [weak self] result in
            switch result {
            case let .success(forecast):
                self?.buildDatasource(forecastList: forecast.list ?? [])
                self?.cityForecast = forecast
            case let .failure(error):
                self?.handleFetchWeatherForcast(error)
            }
            self?.view?.stopActivityIndicator()
        }
    }
    
    private func buildDatasource(forecastList: [Forecast]) {
        let sectionData = forecastList.map { WeatherForeCastSectionData(title: $0.date?.toDateString ?? "", data: buidWeatherForecastFromForcast(forcast: $0)) }
        forecastDatasource = sectionData
    }
    
    private func buidWeatherForecastFromForcast(forcast: Forecast) -> [WeatherForeCastUIModel] {
        return [WeatherForeCastUIModel(localizer.minTemp, value: "\(forcast.main?.tempMin ?? 0.0) \(localizer.celsius)"),
                WeatherForeCastUIModel(localizer.maxTemp, value: "\(forcast.main?.tempMax ?? 0.0) \(localizer.celsius)"),
                WeatherForeCastUIModel(localizer.humidity, value: "\(forcast.main?.humidity ?? 0)"),
                WeatherForeCastUIModel(localizer.pressure, value: "\(forcast.main?.pressure ?? 0)"),
                WeatherForeCastUIModel(localizer.windSpeed, value: "\(forcast.wind?.speed ?? 0.0) \(localizer.meter)"),
        ]
    }
    
    private func handleFetchWeatherForcast(_ error: Error) {
        switch error {
        case WAError.connection, WAError.internet:
            view?.displayAlert(with: localizer.errorHappenedTitle, message: localizer.internetError, firstActionTitle: localizer.retry, secondActionTitle: localizer.cancel, firstActionCompletion: { [weak self] in
                self?.fetchWeatherForecast()
            })
        case let WAError.underlying(_, message):
            view?.displayAlert(with: localizer.errorHappenedTitle, message: message, firstActionTitle: localizer.retry, secondActionTitle: localizer.cancel, firstActionCompletion: { [weak self] in
                self?.fetchWeatherForecast()
            })
        case WAError.parsing:
            view?.displayAlert(with: localizer.errorHappenedTitle, message: localizer.parsingError, firstActionTitle: localizer.retry, secondActionTitle: localizer.cancel, firstActionCompletion: { [weak self] in
                self?.fetchWeatherForecast()
            })
        default:
            break
        }
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
            UserDefaults(suiteName: "WeatherApp")!.set("\(cityForecast.list?.first?.main?.temp ?? 0.0)", forKey: "temp")
        }
    }
    
    func deleteCityForecast() {
        if let city = cityForecast?.city?.name {
            CityForecastDatabaseService.shared.delete(with: city)
            view?.setupAddRightBarButtonItem()
        }
    }
}
