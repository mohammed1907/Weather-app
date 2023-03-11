//
//  Config.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import Foundation

struct Config {
    static let baseURL: String = "https://api.openweathermap.org/"
    static let imgBaseURL: String = "http://openweathermap.org/img/w/"
    static let apiKey = "f5cb0b965ea1564c50c6f1b74534d823"
    struct EndpointPath {
        static let getWeather = "data/2.5/weather"
    }
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
