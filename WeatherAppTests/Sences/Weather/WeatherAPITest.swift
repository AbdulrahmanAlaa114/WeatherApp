//
//  WeatherAPITest.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import XCTest
@testable import WeatherApp

class WeatherAPITests: XCTestCase {
    var api: MockBaseAPI<WeatherNetworking>!
    var weatherAPI: WeatherAPI!

    override func setUp() {
        super.setUp()
        api = MockBaseAPI()
        weatherAPI = WeatherAPI(baseAPI: api)
    }

    override func tearDown() {
        api = nil
        weatherAPI = nil
        super.tearDown()
    }

    func testGetWeatherSuccess() {
        let mockWeatherModel = WeatherModel.testModel
        api.stubbedResult = .success(try! JSONEncoder().encode(mockWeatherModel))

        weatherAPI.getWeather(info: [:]) { result in

            XCTAssertTrue(self.api.isFetchDataCalled)
            switch result {
            case .success(let weatherModel):
                XCTAssertEqual(weatherModel, mockWeatherModel)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }

    func testGetWeatherFailure() {

        let mockError = NetworkError.unknownError
        api.stubbedResult = .failure(mockError)

        weatherAPI.getWeather(info: [:]) { result in
            XCTAssertTrue(self.api.isFetchDataCalled)
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, mockError)
            }
        }
    }
}

