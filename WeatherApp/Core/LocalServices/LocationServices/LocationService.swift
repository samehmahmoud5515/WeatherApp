//
//  LocationService.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import CoreLocation

struct Coordinate {
    let longitude: Double
    let latitude: Double
}

enum LocationError: Error {
    case canNotBeLocated
    case userDenied
}

class UserLocationService: NSObject {
    
    private var locationManager: CLLocationManager?
    
    fileprivate var locationCompletionBlock: ((Result<Coordinate, Error>) -> Void)?
    
    func findUserLocation(then: @escaping ((Result<Coordinate, Error>) -> Void)) {
        self.locationCompletionBlock = then
        if locationManager == nil {
            configureLocationManager()
        }
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.distanceFilter = 100
        locationManager?.delegate = self
        if !isAuthorized {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    var isAuthorized: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
}

extension UserLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            locationCompletionBlock?(.failure(LocationError.userDenied))
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }

        guard location.timestamp.timeIntervalSinceNow < 20 || location.horizontalAccuracy > 0 else {
            print("invalid location received")
            return
        }
        
        locationManager?.stopUpdatingLocation()
        locationCompletionBlock?(.success(location.toCoordinate))
    }
}

extension UserLocationService {
    func reverseGeocodeToCountry(coordinate: Coordinate, completion: ((Result<String, Error>) -> Void)?) {
        return ReverseGeocodeService().reverseGeocodeToCountry(lat: coordinate.latitude, long: coordinate.longitude, completion: completion)
    }
}

extension CLLocation {
    var toCoordinate: Coordinate {
        Coordinate(longitude: coordinate.longitude, latitude: coordinate.latitude)
    }
}

