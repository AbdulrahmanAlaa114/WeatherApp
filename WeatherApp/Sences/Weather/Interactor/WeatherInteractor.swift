//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

class WeatherInteractor: WeatherInteractorInputProtocol {
    
    var presenter: WeatherInteractorOutputProtocol?
    
    private let worker: WeatherWorkersProtocol
    
    init(worker: WeatherWorkersProtocol = WeatherWorker()) {
        self.worker = worker
    }
    
    func getWeather(withLang lang: Double, andLat lat: Double) {
        let info: [String: String] = [
            "q":  "\(lat),\(lang)",
            "key": "80f0d320e92a4407af2204231241403", //TODO: Move this to constant file
            "days": "7"
        ]
        worker.getWeather(with: info) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let weatherData):
                self.presenter?.weatherFetchedSuccessfully(data: weatherData)
            case .failure(let error):
                self.presenter?.weatherFetchingFailed(withError: error)
            }
        }
    }
        
}

