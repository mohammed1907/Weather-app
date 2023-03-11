//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import Alamofire

enum NetworkRouter: URLRequestConvertible {
    // MARK: - Endpoints
    case getWeather(name: String)
    
    // MARK: - Properties
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    var path: String {
        switch self {
        case .getWeather:
            return Config.EndpointPath.getWeather
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getWeather(let name):
            let parameters = ["q": name,"appid": Config.apiKey]
            return parameters
        }
    }
    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        let endpointPath: String = "\(Config.baseURL)\(path)"
        var components = URLComponents(string: endpointPath)
        var urlRequest = URLRequest(url: (components?.url)!)
        components?.queryItems = []
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
