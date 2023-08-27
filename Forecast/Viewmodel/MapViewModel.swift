//
//  MapViewModel.swift
//  Forecast
//
//  Created by Steve Hechio on 27/08/2023.
//

import Foundation
import MapKit

class MapViewModel: ObservableObject {
    private var favWeatherSet = Set<String>()
    
    @Published var uiState: UIState = .loading {
        willSet {
            objectWillChange.send()
        }
    }
    
    var favoriteWeather: [MKCoordinateRegion] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    var annotations: [City] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    
    private var favWeatherUIState = UIState.loading
    
    init() {
        getRemoteWeatherData()
    }
    
    func getRemoteWeatherData(){
        CoreDataManager.shared.fetchDataFromCoreData()?.forEach({ entity in
            let favWeather = entity.toWeatherResponse()
            if !favWeatherSet.contains(favWeather.name) {
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:favWeather.coordinate.lat, longitude: favWeather.coordinate.lon ), span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5))
                favoriteWeather.append(region)
                annotations.append(City(name: favWeather.name, temp: Int(favWeather.mainElement.temp), coordinate: CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)))
                
                favWeatherSet.insert(favWeather.name)
            }
            favWeatherUIState = .success
            updateUIState()
        })
    }
    
    private func updateUIState() {
        if favWeatherUIState == .success {
            uiState = .success
        }
        
        if favWeatherUIState == .failed {
            uiState = .failed
        }
    }
}
