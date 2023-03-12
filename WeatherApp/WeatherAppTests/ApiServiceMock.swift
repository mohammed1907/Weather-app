//
//  ApiServiceMock.swift
//  WeatherAppTests
//
//  Created by farghaly on 12/03/2023.
//

import Foundation
import Alamofire
@testable import WeatherApp

class ApiServiceMock: WeatherService {
    var isFetchDataCalled = false
   
    
    func getWeather(loc: String, completion: @escaping (Alamofire.AFResult<WeatherApp.WeatherModel>) -> Void) {
        isFetchDataCalled = true
    }
}
