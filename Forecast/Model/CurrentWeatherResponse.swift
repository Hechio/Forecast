//
//  CurrentWeatherResponse.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation

struct WeatherResponse: Codable {
    let id: Int
    let coordinate: Coordinate
    let weatherElements: [WeatherElement]
    let mainElement: MainWeatherElement
    let date: Int
    let name: String
    let code: Int
    var lastUpdate: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case weatherElements = "weather"
        case coordinate = "coord"
        case mainElement = "main"
        case date = "dt"
        case code = "cod"
    }
    
    static func emptyInit() -> WeatherResponse {
        return WeatherResponse(
            id: 0,
            coordinate: Coordinate.emptyInit(),
            weatherElements: [],
            mainElement: MainWeatherElement.emptyInit(),
            date: 0,
            name: "",
            code: 0
        )
    }
}

