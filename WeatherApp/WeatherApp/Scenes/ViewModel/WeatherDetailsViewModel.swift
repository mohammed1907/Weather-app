//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Omar Hassanein on 12/03/2023.
//

import Foundation

protocol WeatherDetailsViewModelLogic {
    // MARK: Properties
    var weatherDataInfo: WeatherInfoViewModel? { get }
    var alertMessage: String? { get }
    var state: State { get }
    var city: City? {get set}
    var numberOfCells: Int { get }
    
    // MARK: Actions
    func getWeatherList()
    func getWeather(name: String)
    var showAlertClosure: (() -> Void)? { get set }
    var updateLoadingStatus: (() -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
}

class WeatherDetailsViewModel: WeatherDetailsViewModelLogic {
    var city: City?
    var weather = [WeatherInfo]()
    
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
    var weatherDataInfo: WeatherInfoViewModel? {
        didSet {
            saveWeather()
            self.reloadData?()
        }
    }
    var numberOfCells: Int {
        return weatherDataInfo != nil ? 1 : 0
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
    var reloadData: (() -> Void)?
    // MARK: - prepare weather data
    private func processWeatherData(data: WeatherModel?) {
        if let weather = data {
            weatherDataInfo = WeatherInfoViewModel(data: weather)
        }
    }
    func getWeatherList() {
        if let city = city {
            weather = DataManager.shared.weatherList(city: city)
        }
    }
    func saveWeather() {
        if let city = city {
            _ = DataManager.shared.weatherInfo(weatherStatus: weatherDataInfo?.weatherStatus ?? "", weatherTime: weatherDataInfo?.weatherTime ?? "", weatherTemp: weatherDataInfo?.weatherTemp ?? "", city: city)
            DataManager.shared.save()
            getWeatherList()
        }
    }
}

// MARK: - Network Calls
extension WeatherDetailsViewModel {
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
