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
    let networkConnectivity = NetworkConnectivity.shared
    private var currentWeatherSet = Set<String>()
    
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
        if networkConnectivity.isReachable() {
            locationManager.$location.sink { [weak self] location in
                guard let location = location else { return }
                self?.getWeatherData(location: location)
            }.store(in: &cancellables)
            locationManager.requestLocation()
        }else {
            getWeatherRemoteData()
        }

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
                CoreDataManager.shared.saveWeatherToCoreData(weather: currentWeather)
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
                CoreDataManager.shared.saveForecastToCoreData(weather: forecastWeather.forecastList, cityName: forecastWeather.city.name)
            } else {
                viewmodel.forecastWeatherUIState = .failed
            }
            viewmodel.updateUIState()
            
        }
    }
    
    
    func getWeatherRemoteData(){
        let entity = CoreDataManager.shared.fetchDataFromCoreData()?.first
        
        if let favWeather = entity?.toWeatherResponse() {
            if !currentWeatherSet.contains(favWeather.name) {
                currentWeather = favWeather
                currentWeatherSet.insert(favWeather.name)
            }
            var favList: [ForecastWeather] = []
            let forecast = CoreDataManager.shared.fetchDataFromCoreData(cityName: favWeather.name)
            forecast?.forEach({ entity in
                
                let favWeather = entity.toForecactResponse()
                favList.append(favWeather)
                
            })
            if favList.count == forecast?.count {
                forecastWeather = ForecastResponse(code: "", message: 0, count: 0, list: favList, city: ForecastCity(id: 0, name: favWeather.name, coordinate: Coordinate.emptyInit(), country: ""))
                
                forecastWeatherUIState = .success
                currentWeatherUIState = .success
                updateUIState()
            }
            
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

