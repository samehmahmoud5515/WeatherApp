//
//  LocationService.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import CoreLocation

class UserLocationService: NSObject, UserLocationProvider {

    fileprivate var provider: LocationProvider
    fileprivate var locationCompletionBlock: UserLocationCompletionBlock?

    init(with provider: LocationProvider = CLLocationManager()) {
        self.provider = provider
        super.init()
    }

    func findUserLocation(then: @escaping UserLocationCompletionBlock) {
        self.locationCompletionBlock = then
        if provider.isUserAuthorized {
            provider.requestLocation()
        } else {
            provider.requestWhenInUseAuthorization()
        }
    }
}

extension UserLocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            provider.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location = locations.last {
            locationCompletionBlock?(location, nil)
        } else {
            locationCompletionBlock?(nil, .canNotBeLocated)
        }
    }
}
 
