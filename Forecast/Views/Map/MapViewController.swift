//
//  MapViewController.swift
//  Forecast
//
//  Created by Steve Hechio on 27/08/2023.
//

import UIKit
import Combine
import SwiftUI
import MapKit

class MapViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    @ObservedObject var viewmodel = MapViewModel()
    let indicator = ActivityIndicator.shared

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        viewmodel.$uiState
            .sink { [weak self] state in
                self?.handleUIState(state)
            }
            .store(in: &cancellables)
        
        if viewmodel.uiState == .loading {
            indicator.show(in: self.view)
        }
    }
    
    func handleUIState(_ state: UIState) {
        switch state {
        case .success:
            indicator.hide()
            setupMapView(
                favWeather: viewmodel.favoriteWeather,
                annotations: viewmodel.annotations
                )
        case .failed:
            indicator.hide()
            break
        case .loading:
            indicator.show(in: self.view)
            break
        }
    }
    
    private func setupMapView(favWeather: [MKCoordinateRegion], annotations: [City]){
        
        print("\(favWeather) : \(annotations)")
        let mapUIView = MapView(region: favWeather.first!, annotations: annotations)
        
        let hostingController = UIHostingController(rootView: mapUIView)
        
        let mapView = hostingController.view!
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
