//
//  MainWeatherElement.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation

struct MainWeatherElement: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }

    static func emptyInit() -> MainWeatherElement {
        return MainWeatherElement(
            temp: 0.0,
            feelsLike: 0.0,
            tempMin: 0,
            tempMax: 0,
            pressure: 0,
            humidity: 0
        )
    }
    
}


