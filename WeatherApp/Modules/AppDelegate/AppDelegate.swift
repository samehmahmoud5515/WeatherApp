//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by sameh on 12/4/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureInitViewController()
        
        return true
    }
    
    func configureInitViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: CitiesWeatherForecastViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

