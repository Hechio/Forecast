//
//  MapView.swift
//  Forecast
//
//  Created by Steve Hechio on 27/08/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var region: MKCoordinateRegion
    let annotations: [City]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { city in
            MapAnnotation(coordinate: city.coordinate) {
                CustomCalloutView(cityName: city.name, temperature: String(city.temp))
            }
        }
        .edgesIgnoringSafeArea(.all)
    
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(region:  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)), annotations: [
            City(name: "London", temp: 28, coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
            City(name: "Paris", temp: 27, coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
            City(name: "Rome", temp: 25, coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
            City(name: "Washington DC", temp: 21, coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
        ])
    }
}
