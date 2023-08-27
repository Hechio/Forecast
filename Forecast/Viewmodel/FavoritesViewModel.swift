//
//  FavoritesViewModel.swift
//  Forecast
//
//  Created by Steve Hechio on 26/08/2023.
//

import Foundation
import CoreLocation
import Combine
import CoreData

class FavoritesViewModel: ObservableObject {
    let apiService = OpenWeatherApiService()
    var locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var uiState: UIState = .loading {
        willSet {
            objectWillChange.send()
        }
    }
    
    private var currentWeatherSet = Set<String>()
    
    var currentWeather: [WeatherResponse] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    private var currentWeatherUIState = UIState.loading
    
    init() {
        getRemoteWeatherData()
    }
    
    func getWeatherData(location: CLLocationCoordinate2D){
        apiService.fetchCurrentWeather(lat: location.latitude, lng: location.longitude) { [weak self] weatherResponse, error in
            guard let viewmodel = self else { return }
            
            if let currentWeather = weatherResponse {
                if !viewmodel.currentWeatherSet.contains(currentWeather.name) {
                    viewmodel.currentWeather.append(currentWeather)
                    viewmodel.currentWeatherSet.insert(currentWeather.name)
                    CoreDataManager.shared.saveWeatherToCoreData(weather: currentWeather)
                }
                viewmodel.currentWeatherUIState = .success
            } else {
                viewmodel.currentWeatherUIState = .failed
            }
            viewmodel.updateUIState()
            
        }
    }
    
    
    func getRemoteWeatherData(){
        CoreDataManager.shared.fetchDataFromCoreData()?.forEach({ entity in
            
            let favWeather = entity.toWeatherResponse()
            print("Core Fav\(favWeather)")
            if !currentWeatherSet.contains(favWeather.name) {
                currentWeather.append(favWeather)
                currentWeatherSet.insert(favWeather.name)
            }
            currentWeatherUIState = .success
            updateUIState()
        })
    }
    
    private func updateUIState() {
        if currentWeatherUIState == .success {
            uiState = .success
        }
        
        if currentWeatherUIState == .failed {
            uiState = .failed
        }
    }

    
}
