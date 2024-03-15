//
//  WeatherPresenterTest.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import XCTest
@testable import WeatherApp

class WeatherPresenterTests: XCTestCase {
    
    var presenter: WeatherPresenter!
    var mockView: MockWeatherView!
    var mockInteractor: MockWeatherInteractorInput!
    var mockRouter: MockWeatherRouter!
    var mockWeatherModel: WeatherModel!

    override func setUp() {
        super.setUp()
        mockView = MockWeatherView()
        mockInteractor = MockWeatherInteractorInput()
        mockRouter = MockWeatherRouter()
        presenter = WeatherPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
        mockWeatherModel = WeatherModel.testModel
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
        super.tearDown()
    }

    func testFetchWeatherDataSuccess() {
        mockInteractor.stubbedGetWeatherCompletionResult = .success(mockWeatherModel)

        presenter.fetchWeatherData(withLang: 0.0, andLat: 0.0)

        XCTAssertTrue(mockView.showIndicatorCalled)
        XCTAssertTrue(mockInteractor.getWeatherCalled)
    }

    func testFetchWeatherDataFailure() {

        let mockError = NetworkError.unknownError
        mockInteractor.stubbedGetWeatherCompletionResult = .failure(mockError)

        presenter.fetchWeatherData(withLang: 0.0, andLat: 0.0)

        XCTAssertTrue(mockView.showIndicatorCalled)
        XCTAssertTrue(mockInteractor.getWeatherCalled)
    }
    
    func testGetWeatherData() {
        
        presenter.weatherData = mockWeatherModel

        let weatherData = presenter.getWeatherData()

        XCTAssertEqual(weatherData, mockWeatherModel)
    }
    
    func testWeatherFetchedSuccessfully() {
        let mockWeatherData = WeatherModel.testModel

        presenter.weatherFetchedSuccessfully(data: mockWeatherData)

        XCTAssertFalse(mockView.showIndicatorCalled)
        XCTAssertEqual(presenter.weatherData, mockWeatherData)
        XCTAssertTrue(mockView.reloadDataCalled)
    }
    
    func testWeatherFetchingFailed() {
        let mockError = NetworkError.unknownError

        presenter.weatherFetchingFailed(withError: mockError)

        XCTAssertFalse(mockView.showIndicatorCalled)
        XCTAssertTrue(mockView.hideIndicatorCalled)
        XCTAssertTrue(mockView.showAlertCalled)
        XCTAssertEqual(mockView.capturedAlertTitle, "Error")
        XCTAssertEqual(mockView.capturedAlertMessage, mockError.errorDescription)
    }
}
