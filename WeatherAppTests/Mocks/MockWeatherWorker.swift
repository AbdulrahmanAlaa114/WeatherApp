//
//  MockWeatherWorker.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
@testable import WeatherApp

class MockWeatherWorker: WeatherWorkersProtocol {
    
    var stubbedGetWeatherCompletionResult: Result<WeatherApp.WeatherModel, WeatherApp.NetworkError>?
    var getWeatherCalled = false
    
    func getWeather(with info: [String : Any], completion: @escaping (Result<WeatherApp.WeatherModel, WeatherApp.NetworkError>) -> Void) {
        getWeatherCalled = true
        if let result = stubbedGetWeatherCompletionResult {
            completion(result)
        }
    }
}
