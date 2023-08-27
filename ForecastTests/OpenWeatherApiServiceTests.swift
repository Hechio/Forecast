//
//  OpenWeatherApiServiceTests.swift
//  ForecastTests
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation
import XCTest
@testable import Forecast

class OpenWeatherApiServiceTests: XCTestCase {
    var apiService: OpenWeatherApiService!
    
    override func setUpWithError() throws {
        apiService = OpenWeatherApiService()
    }

    override func tearDownWithError() throws {
        apiService = nil
    }

    func testFetchCurrentWeather_Success() {
        
        let expectation = XCTestExpectation(description: "Fetch current weather")
        
        apiService.fetchCurrentWeather(lat: 37.7749, lng: -122.4194) { (weatherResponse, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(weatherResponse, "Weather response should not be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testFetchCurrentWeather_Error() {
        
        let expectation = XCTestExpectation(description: "Fetch current weather")
        
        apiService.fetchCurrentWeather(lat: 9999, lng: 9999) { (weatherResponse, error) in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertNil(weatherResponse, "Weather response should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchForecastWeather_Success() {
        
        let expectation = XCTestExpectation(description: "Fetch forecast weather")
        
        apiService.fetchForecastWeather(lat: 37.7749, lng: -122.4194) { (forecastResponse, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(forecastResponse, "Forecast response should not be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }


    func testFetchForecastWeather_Error() {
        
        let expectation = XCTestExpectation(description: "Fetch forecast weather")
        
        apiService.fetchForecastWeather(lat: 9999, lng: 9999) { (forecastResponse, error) in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertNil(forecastResponse, "Forecast response should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

