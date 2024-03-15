//
//  MockWeatherView.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import UIKit
@testable import WeatherApp


class MockWeatherView: WeatherViewProtocol {
    var presenter: WeatherPresenterProtocol!

    var showIndicatorCalled = false
    var hideIndicatorCalled = false
    var reloadDataCalled = false
    var showAlertCalled = false
    var capturedAlertTitle: String?
    var capturedAlertMessage: String?
    var capturedAlertActions: [UIAlertAction]?

    func showIndicator() {
        showIndicatorCalled = true
    }

    func hideIndicator() {
        hideIndicatorCalled = true
    }

    func reloadData() {
        reloadDataCalled = true
    }

    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        showAlertCalled = true
        capturedAlertTitle = title
        capturedAlertMessage = message
        capturedAlertActions = actions
    }
}

