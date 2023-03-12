//
//  DataManager.swift
//  WeatherApp
//
//  Created by Omar Hassanein on 12/03/2023.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    //Core Data Saving support
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
//MARK: Save
extension DataManager{
    func city(name: String) -> City {
        let city = City(context: persistentContainer.viewContext)
        city.name = name
        return city
    }
    func weatherInfo(weatherStatus: String, weatherTime: String,weatherTemp:String, city: City) -> WeatherInfo {
        let weatherInfo = WeatherInfo(context: persistentContainer.viewContext)
        weatherInfo.weatherTime = weatherTime
        weatherInfo.weatherTemp = weatherTemp
        weatherInfo.weatherStatus = weatherStatus
        city.addToWeatherinfo(weatherInfo)
        return weatherInfo
    }
}
//MARK: Fetching
extension DataManager{
    func cities() -> [City] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        var fetchedCities: [City] = []
        do {
            fetchedCities = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return fetchedCities
    }
  

    func weatherList(city: City) -> [WeatherInfo] {
        let request: NSFetchRequest<WeatherInfo> = WeatherInfo.fetchRequest()
        print(request)
        request.predicate = NSPredicate(format: "city = %@", city)
        request.sortDescriptors = [NSSortDescriptor(key: "weatherStatus", ascending: false)]
        print(request)
        var fetchedList: [WeatherInfo] = []
        do {
            fetchedList = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedList
    }
}
//MARK: Deletion
extension DataManager{
    func deleteWeatherInfo(weatherInfo: WeatherInfo) {
        let context = persistentContainer.viewContext
        context.delete(weatherInfo)
        save()
    }
    func deleteCity(city: City) {
        let context = persistentContainer.viewContext
        context.delete(city)
        save()
    }
}
