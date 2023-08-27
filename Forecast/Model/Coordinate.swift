//
//  Coordinate.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation

struct Coordinate: Codable {
    let lon, lat: Double
    
    static func emptyInit() -> Coordinate {
        return Coordinate(lon: 0, lat: 0)
    }
}
