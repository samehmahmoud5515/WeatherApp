//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    var cod: String?
    var message, cnt: Int?
    var list: [Forecast]?
    var city: City?
}

// MARK: - City
struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coord: Codable {
    var lat, lon: Double?
}

// MARK: - List
struct Forecast: Codable {
    var dt: Int?
    var main: MainClass?
    var weather: [Weather]?
    var clouds: Clouds?
    var wind: Wind?
    var visibility, pop: Int?
    var sys: Sys?
    var dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
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

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - MainClass
struct MainClass: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, seaLevel, grndLevel, humidity: Int?
    var tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Sys
struct Sys: Codable {
    var pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var main: MainEnum?
    var weatherDescription: Description?
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
