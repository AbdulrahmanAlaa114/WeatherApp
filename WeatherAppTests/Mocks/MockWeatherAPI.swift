//
//  MockWeatherAPI.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
@testable import WeatherApp

class MockWeatherAPIProtocol: WeatherAPIProtocol {
    var stubbedGetWeatherCompletion: Result<WeatherModel, NetworkError>?

    func getWeather(info: [String : Any], completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        if let result = stubbedGetWeatherCompletion {
            completion(result)
        }
    }
}
