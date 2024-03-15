//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

protocol WeatherAPIProtocol {
    
    func getWeather(info: [String: Any], completion: @escaping (Result<WeatherModel, NetworkError>) -> Void)
}

class WeatherAPI: WeatherAPIProtocol {
    private let baseAPI: BaseAPI<WeatherNetworking>

    init(baseAPI: BaseAPI<WeatherNetworking> = BaseAPI<WeatherNetworking>()) {
        self.baseAPI = baseAPI
    }

    func getWeather(info: [String: Any], completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        baseAPI.fetchData(target: .getWeather(info: info), responseClass: WeatherModel.self, completion: completion)
    }
}
