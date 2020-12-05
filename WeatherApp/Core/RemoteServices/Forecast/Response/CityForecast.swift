//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

// MARK: - ForecastResponse
struct CityForecast: Codable {
    var cod: String?
    var message, cnt: Int?
    var list: [Forecast]?
    var city: City?
}

// MARK: - City
struct City: Codable {
  //  var id: Int?
    var name: String?
    var country: String?
}


// MARK: - List
struct Forecast: Codable {
    var main: ForecastDetails?
    var weather: [Weather]?
    var wind: Wind?
    var dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case main, weather, wind
        case dtTxt = "dt_txt"
    }
}

extension Forecast {
    var date: Date? {
        guard let dateText = dtTxt else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: dateText)
    }
}

// MARK: - ForecastDetails
struct ForecastDetails: Codable {
    var temp, tempMin, tempMax: Double?
    var pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    var weatherDescription: String?

    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
