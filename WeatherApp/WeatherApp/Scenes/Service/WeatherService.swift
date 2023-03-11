//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import Foundation
import Alamofire
protocol WeatherService {
    func getWeather(loc:String, completion: @escaping (AFResult<WeatherModel>) -> Void)
}

class WeatherServiceImpl: WeatherService {
    private let service = NetworkService()
    func getWeather(loc: String, completion: @escaping (Alamofire.AFResult<WeatherModel>) -> Void) {
         service.performRequest(route: .getWeather(name: loc), completion: completion)
    }
}
