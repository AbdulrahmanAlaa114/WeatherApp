//
//  EndPoints.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

struct EndPoints {
    
    static let baseURL = URL(string: "https://api.weatherapi.com")!
    
    static let getWeather = "/v1/forecast.json"
}

//https://api.weatherapi.com/v1/forecast.json?q=48.8567%2C2.3508&days=4&key=80f0d320e92a4407af2204231241403'
