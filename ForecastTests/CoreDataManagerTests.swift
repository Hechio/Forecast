//
//  CoreDataManagerTests.swift
//  ForecastTests
//
//  Created by Steve Hechio on 28/08/2023.
//

import XCTest
@testable import Forecast
import CoreData

class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManager.shared
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
    }

    func testSaveWeatherToCoreData() {
        let weatherResponse = WeatherResponse(id: 1, coordinate: Coordinate(lon: 0.0, lat: 0.0), weatherElements: [], mainElement: MainWeatherElement(temp: 25.0, feelsLike: 0.0, tempMin: 20.0, tempMax: 30.0, pressure: 0, humidity: 0), date: 1234567890, name: "Test City", code: 200, lastUpdate: 1234567890)
        
        clearCoreDataStore()
        
        coreDataManager.saveWeatherToCoreData(weather: weatherResponse)

        let fetchedData = coreDataManager.fetchDataFromCoreData()
        XCTAssertNotNil(fetchedData)
        XCTAssertEqual(fetchedData?.count, 1)
        XCTAssertEqual(fetchedData?.first?.cityName, "Test City")
    }
    
    func clearCoreDataStore() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WeatherEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coreDataManager.coreDataStack.managedContext.execute(deleteRequest)
        } catch {
            print("Error clearing Core Data store: \(error)")
        }
    }
}

