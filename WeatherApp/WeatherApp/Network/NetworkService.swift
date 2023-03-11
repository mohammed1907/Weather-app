//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Omar Hassanein on 11/03/2023.
//

import Alamofire

protocol NetworkServiceProtocol {
    @discardableResult
     func performRequest<T: Decodable>(route: NetworkRouter,
                                       completion: @escaping (AFResult<T>) -> Void) -> DataRequest
}
class NetworkService: NetworkServiceProtocol {
    @discardableResult
      func performRequest<T: Decodable>(route: NetworkRouter,
                                        completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
          return AF.request(route).validate().responseDecodable { (response: DataResponse<T, AFError>) in
            completion(response.result)
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }
}
