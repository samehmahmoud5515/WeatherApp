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
    
    init(view: CityWeatherForecastDetailsViewProtocol, cityName: String) {
        self.view = view
        self.cityName = cityName
    }

    func viewDidLoad() {
        let cityForecastObj = CityForecastDatabaseService.shared.fetch(with: cityName)
        
        if cityForecastObj == nil {
            view?.setupAddRightBarButtonItem()
            view?.startActivityIndicator()
            fetchWeatherForecast()
        } else {
            buildDatasource(forecastList: cityForecastObj?.list ?? [])
            cityForecast = cityForecastObj
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

struct SectionData {
    let title: String
    let data : [WeatherForeCastUIModel]

    var numberOfItems: Int {
        return data.count
    }

    subscript(index: Int) -> WeatherForeCastUIModel {
        return data[index]
    }
}

struct WeatherForeCastUIModel {
    let title: String
    let value: String
    
    init(_ title: String, value: String) {
        self.title = title
        self.value = value
    }
}
