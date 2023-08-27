//
//  WeatherViewModel.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {
    var locationManager = LocationManager()
    
    let apiService = OpenWeatherApiService()
    
    @Published var uiState: UIState = .loading {
        willSet {
            objectWillChange.send()
        }
    }
    
    var currentWeather: WeatherResponse = WeatherResponse.emptyInit() {
        willSet {
            objectWillChange.send()
        }
    }
    
    var forecastWeather: ForecastResponse = ForecastResponse.emptyInit() {
        willSet {
            objectWillChange.send()
        }
    }
    
    private var currentWeatherUIState = UIState.loading
    private var forecastWeatherUIState = UIState.loading
    
    init() {
        locationManager.requestLocation()
        locationManager.$location.sink { [weak self] location in
            guard let location = location else { return }
            self?.getWeatherData(location: location)
        }.store(in: &cancellables)
    }
    
    func retry() {
        uiState = .loading
       currentWeatherUIState = .loading
        forecastWeatherUIState = .loading
        
        locationManager.requestLocation()
        locationManager.$location.sink { [weak self] location in
            guard let location = location else { return }
            self?.getWeatherData(location: location)
        }.store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func getWeatherData(location: CLLocationCoordinate2D){
        apiService.fetchCurrentWeather(lat: location.latitude, lng: location.longitude) { [weak self] weatherResponse, error in
            guard let viewmodel = self else { return }
            
            if let currentWeather = weatherResponse {
                viewmodel.currentWeather = currentWeather
                viewmodel.currentWeatherUIState = .success
            } else {
                viewmodel.currentWeatherUIState = .failed
            }
            viewmodel.updateUIState()
            
        }
         apiService.fetchForecastWeather(lat: location.latitude, lng: location.longitude) { [weak self] weatherResponse, error in
            guard let viewmodel = self else { return }
            if let forecastWeather = weatherResponse {
                viewmodel.forecastWeather = forecastWeather
                viewmodel.forecastWeatherUIState = .success
            } else {
                viewmodel.forecastWeatherUIState = .failed
            }
            viewmodel.updateUIState()
            
        }
        
        
    }
    
    private func updateUIState() {
        if currentWeatherUIState == .success, forecastWeatherUIState == .success {
            uiState = .success
        }
        
        if currentWeatherUIState == .failed, forecastWeatherUIState == .failed {
            uiState = .failed
        }
    }
}

