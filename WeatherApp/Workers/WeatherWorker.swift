//
//  WeatherWorker.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

class WeatherWorker: WeatherWorkersProtocol {
    
    let api: WeatherAPIProtocol
   
    init(api: WeatherAPIProtocol = WeatherAPI()) {
        self.api = api
    }
    
    func getWeather(with info: [String: Any], completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        api.getWeather(info: info, completion: completion)
    }
}
