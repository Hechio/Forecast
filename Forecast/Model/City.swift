//
//  City.swift
//  Forecast
//
//  Created by Steve Hechio on 27/08/2023.
//

import Foundation
import CoreLocation

struct City: Identifiable {
    let id = UUID()
    let name: String
    let temp: Int
    let coordinate: CLLocationCoordinate2D
}
