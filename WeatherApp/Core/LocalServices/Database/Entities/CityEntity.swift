//
//  CityEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//
//

import Foundation
import CoreData

@objc(CityEntity)
public class CityEntity: NSManagedObject {
    @nonobjc class func deleteAllRequest() -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CityEntity.entityName)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }
    
    @nonobjc class func deleteAllRequest(id:String) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CityEntity.entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }

    
    @nonobjc class func request() -> NSFetchRequest<CityEntity> {
        let fetchRequest = NSFetchRequest<CityEntity>(entityName: CityEntity.entityName)
        return fetchRequest
    }
}

extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var country: String?
    @NSManaged public var name: String?

}

extension CityEntity {
    var toCity: City {
        return City(name: name, country: country)
    }
    
    func update(with obj: City) {
        country = obj.country
        name = obj.name
    }
}
