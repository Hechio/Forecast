//
//  WeatherElement.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation

struct WeatherElement: Codable {
    let id: Int
    let main, elementDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case elementDescription = "description"
        case icon
    }
    
    static func emptyInit() -> WeatherElement {
        return WeatherElement(
            id: 0,
            main: "",
            elementDescription: "",
            icon: ""
        )
    }
    
    var imageName: String {
        switch main {
            case "Rain": return "forest_rainy"
            case "Clear", "Sunny": return "forest_sunny"
            default: return "forest_cloudy"
        }
    }

    var backgroundColorName: String {
        switch main {
            case "Rain": return "RainyColor"
            case "Clear", "Sunny": return "SunnyColor"
            default: return "CloudyColor"
        }
    }

    var iconImage: String {
        switch main {
            case "Rain": return "rain"
            case "Clear", "Sunny": return "clear"
            default: return "partlysunny"
        }
    }

    
    
}
