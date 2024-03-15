//
//  MockWeatherInteractorOutput.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
@testable import WeatherApp

class MockWeatherInteractorOutput: WeatherInteractorOutputProtocol {
    var weatherFetchedSuccessfullyCalled = false
    var weatherFetchingFailedCalled = false
    var capturedWeatherData: WeatherModel?
    var capturedError: NetworkError?

    func weatherFetchedSuccessfully(data: WeatherModel) {
        weatherFetchedSuccessfullyCalled = true
        capturedWeatherData = data
    }

    func weatherFetchingFailed(withError error: NetworkError) {
        weatherFetchingFailedCalled = true
        capturedError = error
    }
}
