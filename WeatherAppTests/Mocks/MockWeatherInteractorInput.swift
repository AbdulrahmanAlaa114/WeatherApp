//
//  MockWeatherInteractorInput.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
@testable import WeatherApp

class MockWeatherInteractorInput: WeatherInteractorInputProtocol {
    var presenter: WeatherInteractorOutputProtocol?

    var stubbedGetWeatherCompletionResult: Result<WeatherModel, NetworkError>?
    var getWeatherCalled = false

    func getWeather(withLang lang: Double, andLat lat: Double) {
        getWeatherCalled = true
        if let result = stubbedGetWeatherCompletionResult {
            switch result {
            case .success(let data):
                presenter?.weatherFetchedSuccessfully(data: data)
            case .failure(let error):
                presenter?.weatherFetchingFailed(withError: error)
            }
        }
    }
}
