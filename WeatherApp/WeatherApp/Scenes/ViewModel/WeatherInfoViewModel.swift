//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import Foundation

struct WeatherInfoViewModel {
    let cityName: String
    let weatherStatus: String
    let weatherTemp: String
    let wind: String
    let humidity: String
    let iconImage: String
    let weatherTime: String
    init(data: WeatherModel) {
        self.cityName = data.name
        self.weatherStatus = data.weather[0].description
        self.weatherTemp = "\(String(format: "%.0f", data.main.temp - 273.15))°c"
        self.wind = "\(data.wind.speed) Km/h"
        self.humidity = "\(data.main.humidity)%"
        self.iconImage = "\(Config.imgBaseURL)\(data.weather[0].icon).png"
        self.weatherTime = "".getTime()
    }
}
