//
//  WeatherInfo+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Omar Hassanein on 12/03/2023.
//
//

import Foundation
import CoreData


extension WeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfo> {
        return NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
    }

    @NSManaged public var weatherStatus: String?
    @NSManaged public var weatherTemp: String?
    @NSManaged public var weatherTime: String?
    @NSManaged public var city: City?

}

extension WeatherInfo : Identifiable {

}
