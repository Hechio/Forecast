//
//  ForecastWeatherResponse.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation

struct ForecastResponse: Codable {
    let code: String
    let message: Int
    let count: Int
    let list: [ForecastWeather]
    let city: ForecastCity
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case list, city
    }
    
    static func emptyInit() -> ForecastResponse {
        return ForecastResponse(
            code: "",
            message: 0,
            count: 0,
            list: [],
            city: ForecastCity.emptyInit()
        )
    }
    
    var forecastList: [ForecastWeather] {
        var newList: [ForecastWeather] = []
        guard var before = list.first else {
            return newList
        }
        
        if before.date.dateFromMilliseconds().day() != Date().day() {
            newList.append(before)
        }

        for weather in list {
            if weather.date.dateFromMilliseconds().day() != before.date.dateFromMilliseconds().day() {
                newList.append(weather)
            }
            before = weather
        }

        return newList
    }
    
    
}

struct ForecastWeather: Codable {
    var date: Int
    let mainElement: MainWeatherElement
    var elements: [WeatherElement]
    
    enum CodingKeys: String, CodingKey {
        case mainElement = "main"
        case date = "dt"
        case elements = "weather"
    }
    
    static func emptyInit() -> ForecastWeather {
        return ForecastWeather(
            date: 0,
            mainElement: MainWeatherElement.emptyInit(),
            elements: []
        )
    }
    
    
}

extension ForecastWeather: Identifiable, Hashable {
    var id: String { "\(date)" }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: ForecastWeather, rhs: ForecastWeather) -> Bool {
        lhs.id == rhs.id
    }
    
}


struct ForecastCity: Codable {
    let id: Int
    let name: String
    let coordinate: Coordinate
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case coordinate = "coord"
        case country
    }
    
    static func emptyInit() -> ForecastCity {
        return ForecastCity(
            id: 0,
            name: "",
            coordinate: Coordinate.emptyInit(),
            country: ""
        )
    }
}
