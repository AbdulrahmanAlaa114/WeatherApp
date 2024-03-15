////
////  WeatherInteractorTest.swift
////  WeatherAppTests
////
////  Created by Abdulrahman  on 15/03/2024.
////
//
import XCTest
@testable import WeatherApp

class WeatherInteractorTests: XCTestCase {
    
    var interactor: WeatherInteractor!
    var mockPresenter: MockWeatherInteractorOutput!
    var mockWorker: MockWeatherWorker!

    override func setUp() {
        super.setUp()
        mockPresenter = MockWeatherInteractorOutput()
        mockWorker = MockWeatherWorker()
        interactor = WeatherInteractor(worker: mockWorker)
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        mockPresenter = nil
        mockWorker = nil
        interactor = nil
        super.tearDown()
    }

    func testGetWeatherSuccess() {

        let mockWeatherData = WeatherModel.testModel
        mockWorker.stubbedGetWeatherCompletionResult = .success(mockWeatherData)

        interactor.getWeather(withLang: 0.0, andLat: 0.0)

        XCTAssertTrue(mockWorker.getWeatherCalled)
        XCTAssertTrue(mockPresenter.weatherFetchedSuccessfullyCalled)
        XCTAssertEqual(mockPresenter.capturedWeatherData, mockWeatherData)
    }

    func testGetWeatherFailure() {

        let mockError = NetworkError.unknownError
        mockWorker.stubbedGetWeatherCompletionResult = .failure(mockError)

        interactor.getWeather(withLang: 0.0, andLat: 0.0)

        XCTAssertTrue(mockWorker.getWeatherCalled)
        XCTAssertTrue(mockPresenter.weatherFetchingFailedCalled)
        XCTAssertEqual(mockPresenter.capturedError, mockError)
    }
}


