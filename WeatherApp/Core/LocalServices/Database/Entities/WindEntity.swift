//
//  WindEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//
//

import Foundation
import CoreData

@objc(WindEntity)
public class WindEntity: NSManagedObject {
    @nonobjc class func deleteAllRequest() -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: WindEntity.entityName)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }
    
    @nonobjc class func deleteAllRequest(id:String) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: WindEntity.entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }

    
    @nonobjc class func request() -> NSFetchRequest<WindEntity> {
        let fetchRequest = NSFetchRequest<WindEntity>(entityName: WindEntity.entityName)
        return fetchRequest
    }
}

extension WindEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindEntity> {
        return NSFetchRequest<WindEntity>(entityName: "WindEntity")
    }

    @NSManaged public var deg: Int32
    @NSManaged public var speed: Double

}

extension WindEntity {
    var toWind: Wind {
        Wind(speed: speed, deg: Int(deg))
    }
    
    func update(with obj: Wind) {
        deg = Int32(obj.deg ?? 0)
        speed = obj.speed ?? 0.0
    }
}
