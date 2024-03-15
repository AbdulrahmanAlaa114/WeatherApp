//
//  WeatherProtocols.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
import UIKit

protocol WeatherViewProtocol: AnyObject {
    var presenter: WeatherPresenterProtocol! { get set }
    func showAlert(title: String, message: String, actions: [UIAlertAction])
    func showIndicator()
    func hideIndicator()
    func reloadData()
}

protocol WeatherPresenterProtocol {
    var view: WeatherViewProtocol? { get set }
    func fetchWeatherData(withLang lang: Double, andLat lat: Double)
    func getWeatherData() -> WeatherModel
}

protocol WeatherInteractorInputProtocol {
    var presenter: WeatherInteractorOutputProtocol? { get set }
    func getWeather(withLang lang: Double, andLat lat: Double)
}

protocol WeatherInteractorOutputProtocol {
    func weatherFetchedSuccessfully(data: WeatherModel)
    func weatherFetchingFailed(withError error: NetworkError)
}

protocol WeatherWorkersProtocol {
    func getWeather(with info: [String: Any], completion: @escaping (Result<WeatherModel, NetworkError>) -> Void)
}

protocol WeatherRouterProtocol {
    
}
