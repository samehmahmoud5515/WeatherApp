//
//  ReverseGeocodeService.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import CoreLocation

class ReverseGeocodeService {

    func reverseGeocodeToCountry(lat: Double, long: Double, completion: ((Result<String, Error>) -> Void)?) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long)) { placemark, error in
            guard let placemark = placemark, error == nil else {
                return
            }
            completion?(.success(placemark.first?.administrativeArea ?? ""))
        }
    }
}
