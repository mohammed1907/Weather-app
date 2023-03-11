//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import Foundation

protocol WeatherViewModelLogic {
    // MARK: Properties
    var weatherInfo: WeatherInfoModel? { get }
    var alertMessage: String? { get }
    var state: State { get }
    var numberOfCells: Int { get }

    // MARK: Actions
    func getWeather(name: String)
    func getCellViewModel( at indexPath: IndexPath ) -> String
    func getTime() -> String
    var showAlertClosure: (() -> Void)? { get set }
    var updateLoadingStatus: (() -> Void)? { get set }
    var reloadTableViewClosure: (() -> Void)? { get set }
}

class WeatherViewModel: WeatherViewModelLogic {
    private let apiService: WeatherService

    init(apiService: WeatherService = WeatherServiceImpl()) {
        self.apiService = apiService
    }

    // MARK: - API result
    private var weatherData: WeatherModel? {
        didSet {
            self.processWeatherData(data: weatherData)
        }
    }

    // MARK: - fetched result from weatherData
    var weatherInfo: WeatherInfoModel? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfCells: Int {
        return weatherInfo != nil ? 1 : 0
    }
    // MARK: - callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    // MARK: closures for binding
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var reloadTableViewClosure: (() -> Void)?
    // MARK: - prepare weather data
    private func processWeatherData(data: WeatherModel?) {
        if let weather = data {
            weatherInfo = WeatherInfoModel(data: weather)
        }
    }
    // MARK: - process fetched result
    func getCellViewModel( at indexPath: IndexPath ) -> String {
        return weatherInfo?.cityName ?? ""
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

// MARK: - Network Calls
extension WeatherViewModel {
    func getWeather(name: String) {
        state = .loading
        apiService.getWeather(loc: name) {[weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
             self.weatherData = data
              self.state = .populated
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.errorDescription
                    return
            }

        }
    }
}
