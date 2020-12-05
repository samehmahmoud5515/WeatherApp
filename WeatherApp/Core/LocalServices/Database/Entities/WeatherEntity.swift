//
//  WeatherEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//
//

import Foundation
import CoreData

@objc(WeatherEntity)
public class WeatherEntity: NSManagedObject {
    @nonobjc class func deleteAllRequest() -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: WeatherEntity.entityName)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }
    
    @nonobjc class func deleteAllRequest(id:String) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: WeatherEntity.entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }

    
    @nonobjc class func request() -> NSFetchRequest<WeatherEntity> {
        let fetchRequest = NSFetchRequest<WeatherEntity>(entityName: WeatherEntity.entityName)
        return fetchRequest
    }
}

extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var weatherDescription: String?

}

extension WeatherEntity {
    var toWeather: Weather {
        Weather(weatherDescription: weatherDescription)
    }
    
    func update(with obj: Weather) {
        weatherDescription = obj.weatherDescription
    }
}
