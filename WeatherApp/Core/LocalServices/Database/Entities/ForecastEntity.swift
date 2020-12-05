//
//  ForecastEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//
//

import Foundation
import CoreData

@objc(ForecastEntity)
public class ForecastEntity: NSManagedObject {
    @nonobjc class func deleteAllRequest() -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ForecastEntity.entityName)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }
    
    @nonobjc class func deleteAllRequest(id:String) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ForecastEntity.entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }

    
    @nonobjc class func request() -> NSFetchRequest<ForecastEntity> {
        let fetchRequest = NSFetchRequest<ForecastEntity>(entityName: ForecastEntity.entityName)
        return fetchRequest
    }
}

extension ForecastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastEntity> {
        return NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
    }

    @NSManaged public var dtTxt: String?
    @NSManaged public var main: ForecastDetailsEntity?
    @NSManaged public var weather: Set<WeatherEntity>?
    @NSManaged public var wind: WindEntity?

}

// MARK: Generated accessors for weather
extension ForecastEntity {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherEntity)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherEntity)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension ForecastEntity {
    var toForecast: Forecast {
        let detailObj = main?.toForecastDetails
        let weatherObj = weather?.map { $0.toWeather }
        let windObj = wind?.toWind
        return Forecast(main: detailObj, weather: weatherObj, wind: windObj, dtTxt: dtTxt)
    }
    
    func update(with forecast: Forecast) {
        dtTxt = forecast.dtTxt
    }
}
