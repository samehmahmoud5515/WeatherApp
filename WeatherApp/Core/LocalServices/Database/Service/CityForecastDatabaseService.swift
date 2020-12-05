//
//  CityForecastDatabaseService.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//

import CoreData

class CityForecastDatabaseService {
    
    static let shared = CityForecastDatabaseService()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func save(cityForecast: CityForecast) {
        let managedContext = persistentContainer.viewContext
        let cityEntity = CityEntity(context: managedContext)
        var forecastEntities = [ForecastEntity]()
        let cityForecastEntity = CityForecastEntity(context: managedContext)
        if let city = cityForecast.city {
            cityEntity.update(with: city)
        }
        
        cityForecast.list?.compactMap { $0 }.forEach { forecast in
            let forcastEntiy = ForecastEntity(context: managedContext)
            let windEnity = WindEntity(context: managedContext)
            windEnity.update(with: forecast.wind ?? Wind())
            let detailsEntity = ForecastDetailsEntity(context: managedContext)
            detailsEntity.update(with: forecast.main ?? ForecastDetails())
            
            var weatherEntities = [WeatherEntity]()
            forecast.weather?.compactMap { $0 }.forEach { weather in
                let weatherEntity = WeatherEntity(context: managedContext)
                weatherEntity.update(with: weather)
                weatherEntities.append(weatherEntity)
            }
            
            forcastEntiy.update(with: forecast)
            forcastEntiy.wind = windEnity
            forcastEntiy.main = detailsEntity
            forcastEntiy.weather = Set(weatherEntities.map { $0 })
            forecastEntities.append(forcastEntiy)
        }
        
        cityForecastEntity.city = cityEntity
        cityForecastEntity.list = Set(forecastEntities.map { $0 })

      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func fetchAllForecasts() -> [CityForecast] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = CityForecastEntity.request()

        do {
            let cityForecast = try managedContext.fetch(fetchRequest)
            return cityForecast.map { $0.toCityForecast }.compactMap { $0 }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    func delete(with cityName: String) {
        let managedContext = persistentContainer.viewContext
        let request = CityForecastEntity.deleteAllRequest(cityName: cityName)
        
        do {
            try managedContext.execute(request)
        }
        catch let error as NSError {
            print("Could not Delete. \(error), \(error.userInfo)")
        }
    }
    
    func fetch(with cityName: String) -> CityForecast? {
        let managedContext = persistentContainer.viewContext
        let request = CityForecastEntity.request(cityName: cityName)
        
        do {
            let cityForecast = try managedContext.fetch(request)
            return cityForecast.map { $0.toCityForecast }.compactMap { $0 }.first
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
}
