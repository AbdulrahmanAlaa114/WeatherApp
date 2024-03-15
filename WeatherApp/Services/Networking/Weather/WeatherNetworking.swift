//
//  WeatherNetworking.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

enum WeatherNetworking {
    case getWeather(info: [String: Any])
}

extension WeatherNetworking: TargetType {
    
    var baseURL: URL {
        return EndPoints.baseURL
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return EndPoints.getWeather
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return [
            "Accept":"application/json",
            "Content-Type":"application/json"
        ]
    }
    
    var urlParameters: [String : Any]? {
        switch self {
        case .getWeather(let info):
            return info
        }
    }
    
    var body: Data? {
        switch self {
        case .getWeather:
            return nil
        }
    }
    
}
