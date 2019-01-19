//
//  WeatherForcastEntity+CoreDataProperties.swift
//  
//
//  Created by Syed, Azharuddin on 1/18/19.
//
//

import Foundation
import CoreData


extension WeatherForcastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForcastEntity> {
        return NSFetchRequest<WeatherForcastEntity>(entityName: "WeatherForcastEntity")
    }

    @NSManaged public var value: Double
    @NSManaged public var year: Int64
    @NSManaged public var month: Int16

}
