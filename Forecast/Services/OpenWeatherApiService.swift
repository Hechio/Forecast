//
//  OpenWeatherApiService.swift
//  Forecast
//
//  Created by Steve Hechio on 24/08/2023.
//

import Foundation

class OpenWeatherApiService {
    typealias CurrentWeatherCompletionHandler = (WeatherResponse?, Error?) -> Void
    typealias ForecastCompletionHandler = (ForecastResponse?, Error?) -> Void
    
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let apiKey = "a8b0b7460b45439dd84f411d489c7898"

    private enum Endpoint: String {
        case forecastWeather = "forecast"
        case currentWeather = "weather"
    }
        
    private func baseUrl(_ endpoint: Endpoint, lat: Double, lng: Double) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/\(endpoint.rawValue)?lat=\(lat)&lon=\(lng)&appid=\(self.apiKey)&units=metric")!
    }
    
    private func fetchWeatherData<T: Codable>(lat: Double,lng: Double,
                                            endpoint: Endpoint,
                                            completionHandler completion:  @escaping (_ object: T?,_ error: Error?) -> ()) {
        
        let url = baseUrl(endpoint, lat: lat, lng: lng )
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, ResponseError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500))
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(T.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, ResponseError.anyError)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchCurrentWeather(lat: Double, lng: Double, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        fetchWeatherData(lat: lat, lng: lng, endpoint: .currentWeather) { (weather: WeatherResponse?, error) in
            completion(weather, error)
        }
    }
    
    func fetchForecastWeather(lat: Double, lng: Double, completionHandler completion: @escaping ForecastCompletionHandler) {
        fetchWeatherData(lat: lat, lng: lng, endpoint: .forecastWeather) { (weather: ForecastResponse?, error) in
            completion(weather, error)
        }
    }
        
    
}
