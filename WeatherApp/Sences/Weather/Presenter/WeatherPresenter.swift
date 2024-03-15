//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

class WeatherPresenter: WeatherPresenterProtocol {
   
    weak var view: WeatherViewProtocol?
    private let interactor: WeatherInteractorInputProtocol
    private let router: WeatherRouterProtocol
    var weatherData: WeatherModel!

    init(view: WeatherViewProtocol, interactor: WeatherInteractorInputProtocol, router: WeatherRouterProtocol) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
        
    }
    
    func fetchWeatherData(withLang lang: Double, andLat lat: Double) {
        view?.showIndicator()
        interactor.getWeather(withLang: lang, andLat: lat)
    }
    
    func getWeatherData() -> WeatherModel {
        weatherData
    }
    
    
}

extension WeatherPresenter: WeatherInteractorOutputProtocol {
    
    func weatherFetchedSuccessfully(data: WeatherModel) {
        view?.hideIndicator()
        weatherData = data
        view?.reloadData()
    }
    
    func weatherFetchingFailed(withError error: NetworkError) {
        view?.hideIndicator()
        view?.showAlert(title: "Error", message: error.errorDescription, actions: [])

    }
    
}
