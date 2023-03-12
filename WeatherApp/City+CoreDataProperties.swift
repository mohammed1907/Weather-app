//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Omar Hassanein on 12/03/2023.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var weatherinfo: NSSet?

}

// MARK: Generated accessors for weatherinfo
extension City {

    @objc(addWeatherinfoObject:)
    @NSManaged public func addToWeatherinfo(_ value: WeatherInfo)

    @objc(removeWeatherinfoObject:)
    @NSManaged public func removeFromWeatherinfo(_ value: WeatherInfo)

    @objc(addWeatherinfo:)
    @NSManaged public func addToWeatherinfo(_ values: NSSet)

    @objc(removeWeatherinfo:)
    @NSManaged public func removeFromWeatherinfo(_ values: NSSet)

}

extension City : Identifiable {

}
