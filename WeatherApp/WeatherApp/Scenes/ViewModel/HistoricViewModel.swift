//
//  HistoricViewModel.swift
//  WeatherApp
//
//  Created by Fraghaly on 12/03/2023.
//

import Foundation

protocol HistoricViewModelLogic {
    // MARK: Properties
    var city: City? {get set}
    var numberOfCells: Int { get }
    
    // MARK: Actions
    func getCellViewModel( at indexPath: IndexPath ) -> WeatherInfo
    func getWeatherList()
    var reloadData: (() -> Void)? { get set }
    var emptyData: (() -> Void)? { get set }
}

class HistoricViewModel: HistoricViewModelLogic {
  
    // MARK: closures for binding
    var reloadData: (() -> Void)?
    var emptyData: (() -> Void)?
    
    var city: City?
    var weatherlist = [WeatherInfo](){
        didSet{
            if weatherlist.count > 0 {
                reloadData?()
            }else{
                emptyData?()
            }
        }
    }
    var numberOfCells: Int {
        return weatherlist.count
    }
    // MARK: - prepare weather data
    func getWeatherList() {
        if let city = city {
            weatherlist = DataManager.shared.weatherList(city: city)
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> WeatherInfo {
        return weatherlist[indexPath.row]
    }

}


