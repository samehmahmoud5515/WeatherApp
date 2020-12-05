//
//  ForecastDetailsEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by sameh on 12/5/20.
//
//

import Foundation
import CoreData

@objc(ForecastDetailsEntity)
public class ForecastDetailsEntity: NSManagedObject {
    @nonobjc class func deleteAllRequest() -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ForecastDetailsEntity.entityName)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }
    
    @nonobjc class func deleteAllRequest(id:String) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ForecastDetailsEntity.entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        return NSBatchDeleteRequest(fetchRequest:fetchRequest)
    }

    
    @nonobjc class func request() -> NSFetchRequest<ForecastDetailsEntity> {
        let fetchRequest = NSFetchRequest<ForecastDetailsEntity>(entityName: ForecastDetailsEntity.entityName)
        //fetchRequest.fetchLimit = 1
       // fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return fetchRequest
    }
}

extension ForecastDetailsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastDetailsEntity> {
        return NSFetchRequest<ForecastDetailsEntity>(entityName: "ForecastDetailsEntity")
    }

    @NSManaged public var humidity: Int32
    @NSManaged public var pressure: Int32
    @NSManaged public var temp: Double
    @NSManaged public var tempMax: Double
    @NSManaged public var tempMin: Double

}


import CoreData

extension NSManagedObject {
    
    class var entityName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}


extension NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
    
}

extension ForecastDetailsEntity {
    var toForecastDetails: ForecastDetails {
        ForecastDetails(temp: temp, tempMin: tempMin, tempMax: tempMax, pressure: Int(pressure), humidity: Int(humidity))
    }
    
    func update(with obj: ForecastDetails) {
        temp = obj.temp ?? 0.0
        tempMin = obj.tempMin ?? 0.0
        tempMax = obj.tempMax ?? 0.0
        pressure = Int32(obj.pressure ?? 0)
        humidity = Int32(obj.humidity ?? 0)
    }
}
