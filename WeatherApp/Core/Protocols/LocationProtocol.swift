//
//  LocationProtocol.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import CoreLocation


protocol LocationProvider {
    var isUserAuthorized: Bool { get }
    func requestWhenInUseAuthorization()
    func requestLocation()
}

enum UserLocationError: Swift.Error {
    case canNotBeLocated
}


typealias Coordinate = CLLocationCoordinate2D

protocol UserLocation {
   var coordinate: Coordinate { get }
}

extension CLLocation: UserLocation { }


typealias UserLocationCompletionBlock = (UserLocation?, UserLocationError?) -> Void

extension CLLocationManager: LocationProvider {
    var isUserAuthorized: Bool {
        return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
    }
}

protocol UserLocationProvider {
    func findUserLocation(then: @escaping UserLocationCompletionBlock)
    func reverseGeocodeToCountry(coordinate: Coordinate, completion: ((Result<String, Error>) -> Void)?)
}

extension UserLocationProvider {
    func reverseGeocodeToCountry(coordinate: Coordinate, completion: ((Result<String, Error>) -> Void)?) {
        return ReverseGeocodeService().reverseGeocodeToCountry(lat: coordinate.latitude, long: coordinate.longitude, completion: completion)
    }
}
