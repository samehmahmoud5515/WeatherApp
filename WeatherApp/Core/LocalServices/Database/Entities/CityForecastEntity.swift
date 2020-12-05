//
//  CityForecastEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//
//

import Foundation
import CoreData

@objc(CityForecastEntity)
public class CityForecastEntity: NSManagedObject {
    @nonobjc class func deleteAllRequest() -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CityForecastEntity.entityName)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }
    
    @nonobjc class func deleteAllRequest(cityName: String) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CityForecastEntity.entityName)
        fetchRequest.predicate = NSPredicate(format: "city.name = %@", cityName)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }

    
    @nonobjc class func request() -> NSFetchRequest<CityForecastEntity> {
        let fetchRequest = NSFetchRequest<CityForecastEntity>(entityName: CityForecastEntity.entityName)
        return fetchRequest
    }
    
    @nonobjc class func request(cityName: String) -> NSFetchRequest<CityForecastEntity> {
        let fetchRequest = NSFetchRequest<CityForecastEntity>(entityName: CityForecastEntity.entityName)
        fetchRequest.predicate = NSPredicate(format: "city.name = %@", cityName)
        fetchRequest.fetchLimit = 1
        return fetchRequest
    }
}

extension CityForecastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityForecastEntity> {
        return NSFetchRequest<CityForecastEntity>(entityName: "CityForecastEntity")
    }

    @NSManaged public var city: CityEntity?
    @NSManaged public var list: Set<ForecastEntity>?

}

// MARK: Generated accessors for list
extension CityForecastEntity {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: ForecastEntity)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: ForecastEntity)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}

extension CityForecastEntity {
    var toCityForecast: CityForecast? {
        let cityObj = city?.toCity
        let listObj = list?.map{ $0.toForecast }
        
        return CityForecast(list: listObj, city: cityObj)
    }
}
