//
//  FavoritesViewController.swift
//  Forecast
//
//  Created by Steve Hechio on 26/08/2023.
//

import UIKit
import GooglePlaces
import Combine
import SwiftUI

class FavoritesViewController: UIViewController {
    
    lazy var addIconButton: UIButton = {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
        let addIcon = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
        
        let button = UIButton(type: .custom)
        button.setImage(addIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //button.tintColor = UIColor(named: "AccentColor")
        button.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
        return button
    }()
    
    var cancellables = Set<AnyCancellable>()
    
    @ObservedObject var viewmodel = FavoritesViewModel()
    let indicator = ActivityIndicator.shared
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupNavigation()
        viewmodel.$uiState
            .sink { [weak self] state in
                self?.handleUIState(state)
            }
            .store(in: &cancellables)
        
        if viewmodel.uiState == .loading {
            view.backgroundColor = .white
            indicator.show(in: self.view)
        }
    }
    
    func handleUIState(_ state: UIState) {
        switch state {
        case .success:
            indicator.hide()
            setupMainView(
                currentWeather: viewmodel.currentWeather
                )
        case .failed:
            setUpErrorView()
            break
        case .loading:
            view.backgroundColor = .white
            indicator.show(in: self.view)
            break
        }
    }

    private func setUpErrorView(){
        indicator.hide()
    }
    
    func setupMainView(currentWeather: [WeatherResponse]) {
        let favUIView = FavoritesListView(favoriteList: currentWeather)
        let hostingController = UIHostingController(rootView: favUIView)
        
        let favView = hostingController.view!
        favView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        
        view.addSubview(favView)
        
        NSLayoutConstraint.activate([
            favView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
}

extension FavoritesViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        viewmodel.getWeatherData(location: place.coordinate)
        
        print("Place coord: \(place.coordinate)  \(place.coordinate.longitude)")
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension FavoritesViewController {
    
    func setupNavigation() {
        let font = UIFont(name: "Axiforma-Medium", size: 36) ?? UIFont.systemFont(ofSize: 36, weight: .bold)
        navigationItem.title = "Favorites"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addIconButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "AccentColor")!,
            .font: font
        ]
        
        navigationController?.navigationBar.frame.size.height = 120
    }
    
    @objc func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let fields: GMSPlaceField =
        GMSPlaceField(rawValue: UInt64(UInt(GMSPlaceField.name.rawValue) |
        UInt(GMSPlaceField.coordinate.rawValue)))
        autocompleteController.placeFields = fields
        present(autocompleteController, animated: true, completion: nil)
    }
}
