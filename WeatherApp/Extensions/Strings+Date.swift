//
//  Strings+Date.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

extension String {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "MMM d"
            return formatter.string(from: date)
        }
        return ""
    }
}
