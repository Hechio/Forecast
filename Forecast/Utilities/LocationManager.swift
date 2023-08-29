//
//  LocationManager.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import SwiftUI
import Combine
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var location: CLLocationCoordinate2D?
    private var locationSubject = PassthroughSubject<CLLocationCoordinate2D?, Never>()
    private var authorizationStatusSubject = PassthroughSubject<CLAuthorizationStatus, Never>()
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    func requestLocationPermission() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            authorizationStatusSubject.send(.denied)
        case .authorizedAlways:
            authorizationStatusSubject.send(.authorizedAlways)
            manager.requestLocation()
        case .authorizedWhenInUse:
            authorizationStatusSubject.send(.authorizedWhenInUse)
            manager.requestLocation()
            
        @unknown default:
            fatalError("Unhandled authorization status")
        }
    }
    
    func requestLocationPermissionUpdate() {
        requestLocationPermission()
        authorizationStatusSubject
            .filter { $0 == .authorizedWhenInUse }
            .sink { _ in
                self.manager.requestLocation()
            }
            .store(in: &cancellables)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first?.coordinate {
            location = newLocation
            locationSubject.send(newLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error)")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationStatusSubject.send(.authorizedWhenInUse)
        case .denied, .restricted:
            authorizationStatusSubject.send(.denied)
        case .notDetermined:
            authorizationStatusSubject.send(.denied)
        default:
            break
        }
    }
    func getLocationUpdates() -> AnyPublisher<CLLocationCoordinate2D?, Never> {
        return locationSubject.eraseToAnyPublisher()
    }
    
    func getAuthorizationStatusUpdates() -> AnyPublisher<CLAuthorizationStatus, Never> {
        return authorizationStatusSubject.eraseToAnyPublisher()
    }
}
