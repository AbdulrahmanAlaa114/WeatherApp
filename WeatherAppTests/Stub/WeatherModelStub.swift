//
//  WeatherModelStub.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
@testable import WeatherApp

extension WeatherModel {
    static var testModel: WeatherModel = WeatherModel(forecast:
        Forecast(forecastday: [
            Forecastday(date: "2024-03-15", day: Day(avgtempC: 15.0)),
            Forecastday(date: "2024-03-16", day: Day(avgtempC: 16.0)),
            Forecastday(date: "2024-03-17", day: Day(avgtempC: 17.0)),
            Forecastday(date: "2024-03-18", day: Day(avgtempC: 18.0)),
            Forecastday(date: "2024-03-19", day: Day(avgtempC: 19.0)),
            Forecastday(date: "2024-03-20", day: Day(avgtempC: 20.0)),
            Forecastday(date: "2024-03-21", day: Day(avgtempC: 21.0))
        ]))
}
