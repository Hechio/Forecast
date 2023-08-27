//
//  CoreDataHelper.swift
//  Forecast
//
//  Created by Steve Hechio on 27/08/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let coreDataStack = CoreDataStack(modelName: "Weather")
    
    func saveWeatherToCoreData(weather: WeatherResponse) {
        let context = coreDataStack.managedContext
        
        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityName == %@", weather.name)
        
        do {
            if let existingWeather = try context.fetch(fetchRequest).first {
                existingWeather.cityName = weather.name
                existingWeather.code = Int64(weather.code)
                existingWeather.date = Int64(weather.date)
                existingWeather.elementDescription = weather.weatherElements.first?.elementDescription
                existingWeather.id = Int64(weather.id)
                existingWeather.main = weather.weatherElements.first?.main
                existingWeather.lng = weather.coordinate.lon
                existingWeather.lat = weather.coordinate.lat
                existingWeather.temp = weather.mainElement.temp
                existingWeather.tempMax = weather.mainElement.tempMax
                existingWeather.tempMin = weather.mainElement.tempMin
                existingWeather.lastUpdate = Int64(Date().timeIntervalSince1970)
                
                coreDataStack.saveContext()
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "WeatherEntity", in: context)!
                let dataObject = NSManagedObject(entity: entity, insertInto: context)
                dataObject.setValue(weather.name, forKeyPath: "cityName")
                dataObject.setValue(weather.code, forKeyPath: "code")
                dataObject.setValue(weather.date, forKeyPath: "date")
                dataObject.setValue(weather.weatherElements.first?.elementDescription, forKeyPath: "elementDescription")
                dataObject.setValue(weather.id, forKeyPath: "id")
                dataObject.setValue(false, forKeyPath: "isCurrentLocation")
                dataObject.setValue(weather.weatherElements.first?.main, forKeyPath: "main")
                dataObject.setValue(weather.coordinate.lon, forKeyPath: "lng")
                dataObject.setValue(weather.coordinate.lat, forKeyPath: "lat")
                
                dataObject.setValue(weather.mainElement.temp, forKeyPath: "temp")
                dataObject.setValue(weather.mainElement.tempMax, forKeyPath: "tempMax")
                dataObject.setValue(weather.mainElement.tempMin, forKeyPath: "tempMin")
                dataObject.setValue(Int(Date().timeIntervalSince1970), forKeyPath: "lastUpdate")
                
                coreDataStack.saveContext()
            }
        } catch {
            print("Error saving weather data: \(error.localizedDescription)")
        }
    }
    
    func fetchDataFromCoreData() -> [WeatherEntity]? {
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext

        let fetchRequest: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        do {
            let fetchedData = try context.fetch(fetchRequest)
            return fetchedData
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
}



extension WeatherEntity {
    func toWeatherResponse() -> WeatherResponse {
        return WeatherResponse(id: Int(id), coordinate: Coordinate(lon: lng, lat: lat), weatherElements: [WeatherElement(id: 0, main: main ?? "", elementDescription: elementDescription ?? "", icon: "")], mainElement: MainWeatherElement(temp: temp, feelsLike: 0, tempMin: tempMin, tempMax: tempMax, pressure: 0, humidity: 0), date: Int(date), name: cityName ?? "", code: Int(code), lastUpdate: Int(lastUpdate))
    }
}
