//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import Foundation

protocol CityViewModelLogic:WeatherInfoDelegate {
    // MARK: Properties
    var numberOfCells: Int { get }
    var cityArray: [City]? { get set}
    // MARK: Actions
    func getCellViewModel( at indexPath: IndexPath ) -> City
    func getCities()
    var  reloadData: (() -> Void)? { get set }
    func getCity(name: String)
}

class CityViewModel: CityViewModelLogic {
    func getCity(name: String) {
        let city = DataManager.shared.city(name: name)
        cityArray?.append(city)
        DataManager.shared.save()
    }
    
   
    // MARK: - fetched result from addcity
    var cityArray: [City]? = [] {
        didSet {
            self.reloadData?()
        }
    }
    var numberOfCells: Int {
        return cityArray?.count ?? 0
    }
    // MARK: closures for binding
    var reloadData: (() -> Void)?

    
    // MARK: - process fetched result
    func getCellViewModel( at indexPath: IndexPath ) -> City {
        return cityArray![indexPath.row]
    }
    
 
    // MARK: - get current time
    func getCities() {
        cityArray = DataManager.shared.cities()

        }
}


