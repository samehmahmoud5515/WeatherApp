//
//  CitiesService.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import Foundation

typealias Cities = [String]
//typealias Countries = [[String: [String]]]

class CitiesService {
    func loadAllCities() -> Cities? {
        
        var contentData: Data?
        if let path = Bundle.main.path(forResource: "cities", ofType: ".json") {
            contentData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }

        guard let data = contentData else {
            return nil
        }

        // Read data from .json
        do {
            let jsonModel = try JSONDecoder().decode(Cities.self, from: data)
            return jsonModel
        } catch {
            print(error)
        }
        
        return nil
    }
}
