//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import Foundation

protocol CityViewModelLogic {
    // MARK: Properties
    var numberOfCells: Int { get }
    var cityArray: [String]? { get set}
    // MARK: Actions
    func getCellViewModel( at indexPath: IndexPath ) -> String
    func getTime() -> String
    var reloadData: (() -> Void)? { get set }
}

class CityViewModel: CityViewModelLogic {
   
    // MARK: - fetched result from addcity
    var cityArray: [String]? = [] {
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
    func getCellViewModel( at indexPath: IndexPath ) -> String {
        return cityArray?[indexPath.row] ?? ""
    }

 
    // MARK: - get current time
    func getTime() -> String {
         let time = Date()
         let timeFormatter = DateFormatter()
         timeFormatter.dateFormat = "HH:mm a"
         timeFormatter.locale = Locale(identifier: "en")
         let stringDate = timeFormatter.string(from: time)
         return stringDate
        }
}


