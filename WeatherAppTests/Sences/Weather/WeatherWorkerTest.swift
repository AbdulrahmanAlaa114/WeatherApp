//
//  WeatherWorkerTest.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import XCTest
@testable import WeatherApp

class MoviesWorkerTests: XCTestCase {
    
    var worker: WeatherWorker!
    var mockAPI: MockWeatherAPIProtocol!
    var mockCompletionResult: Result<WeatherModel, NetworkError>!

    override func setUp() {
        super.setUp()
        mockAPI = MockWeatherAPIProtocol()
        worker = WeatherWorker(api: mockAPI)
    }

    override func tearDown() {
        mockAPI = nil
        worker = nil
        mockCompletionResult = nil
        super.tearDown()
    }

    func testGetWeatherSuccess() {

        let mockInfo: [String: Any] = [
            "q": "0.0,0.0",
            "key": "mock-api-key",
            "days": "7"
        ]
        let expectedWeatherModel = WeatherModel.testModel
        mockCompletionResult = .success(expectedWeatherModel)
        mockAPI.stubbedGetWeatherCompletion = mockCompletionResult

        worker.getWeather(with: mockInfo) { result in
            switch result {
            case .success(let weatherModel):
                XCTAssertEqual(weatherModel, expectedWeatherModel)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }

    func testGetWeatherFailure() {

        let mockInfo: [String: Any] = [
            "q": "lat,long",
            "key": "key",
            "days": "7"
        ]
        let expectedError = NetworkError.unknownError
        mockCompletionResult = .failure(expectedError)
        mockAPI.stubbedGetWeatherCompletion = mockCompletionResult

        worker.getWeather(with: mockInfo) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, expectedError)
            }
        }
    }
}
