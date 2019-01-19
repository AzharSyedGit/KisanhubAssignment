//
//  MetricLocationEntity+CoreDataProperties.swift
//  
//
//  Created by Syed, Azharuddin on 1/18/19.
//
//

import Foundation
import CoreData


extension MetricLocationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MetricLocationEntity> {
        return NSFetchRequest<MetricLocationEntity>(entityName: "MetricLocationEntity")
    }

    @NSManaged public var metric: String?
    @NSManaged public var location: String?
    @NSManaged public var weatherForcast: NSSet?

}

// MARK: Generated accessors for weatherForcast
extension MetricLocationEntity {

    @objc(addWeatherForcastObject:)
    @NSManaged public func addToWeatherForcast(_ value: WeatherForcastEntity)

    @objc(removeWeatherForcastObject:)
    @NSManaged public func removeFromWeatherForcast(_ value: WeatherForcastEntity)

    @objc(addWeatherForcast:)
    @NSManaged public func addToWeatherForcast(_ values: NSSet)

    @objc(removeWeatherForcast:)
    @NSManaged public func removeFromWeatherForcast(_ values: NSSet)

}
