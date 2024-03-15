//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

struct WeatherModel: Codable, Equatable {
    let forecast: Forecast?
}

struct Forecast: Codable, Equatable {
    let forecastday: [Forecastday]?
}

struct Forecastday: Codable, Equatable {
    let date: String?
    let day: Day?
}

struct Day: Codable, Equatable {
    let avgtempC: Double?
    
    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.avgtempC == rhs.avgtempC
    }
}

extension WeatherModel {
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.forecast == rhs.forecast
    }
}

extension Forecast {
    static func == (lhs: Forecast, rhs: Forecast) -> Bool {
        return lhs.forecastday == rhs.forecastday
    }
}

extension Forecastday {
    static func == (lhs: Forecastday, rhs: Forecastday) -> Bool {
        return lhs.date == rhs.date && lhs.day == rhs.day
    }
}
