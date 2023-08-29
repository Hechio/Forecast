//
//  CurrentViewController.swift
//  Forecast
//
//  Created by Steve Hechio on 24/08/2023.
//

import UIKit
import SwiftUI
import Combine

class CurrentViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    var showFavDetails = false
    var favCurrentWeather = WeatherResponse.emptyInit()
    @ObservedObject var viewmodel = WeatherViewModel()
    let indicator = ActivityIndicator.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showFavDetails {
            viewmodel.getFavoriteForecast(cityName: favCurrentWeather.name)
            viewmodel.$uiState
                .sink { [weak self] state in
                    if state == .success {
                        self?.handleFavUIState(state)
                    }
                }
                .store(in: &cancellables)
            
            
        }else {
            setupViews()
        }
    }
    
    func setupViews(){
        setUpNavigationButtons()
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
    
    func setUpNavigationButtons(){
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let searchIcon = UIImage(systemName: "magnifyingglass.circle.fill", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
        let mapIcon = UIImage(systemName: "map.circle.fill", withConfiguration: symbolConfiguration)?.withRenderingMode(.alwaysTemplate)
        
        
        let searchButton = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(searchButtonTapped))
        let mapButton = UIBarButtonItem(image: mapIcon, style: .plain, target: self, action: #selector(mapButtonTapped))
        
        searchButton.tintColor = UIColor.white.withAlphaComponent(0.8)
        mapButton.tintColor = UIColor.white.withAlphaComponent(0.8)
        
        navigationItem.rightBarButtonItems = [mapButton, searchButton]
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    @objc func mapButtonTapped() {
        navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
    func handleFavUIState(_ state: UIState) {
        switch state {
        case .success:
            print("Modal: \(viewmodel.forecastWeather)")
            indicator.hide()
            setupMainForecastView(currentWeather: favCurrentWeather, forecastWeather: viewmodel.forecastWeather)
        case .failed:
            setUpErrorView()
            break
        case .loading:
            view.backgroundColor = .white
            indicator.show(in: self.view)
            break
        }
    }
    
    func handleUIState(_ state: UIState) {
        switch state {
        case .success:
            indicator.hide()
            setupMainForecastView(
                currentWeather: viewmodel.currentWeather,
                forecastWeather: viewmodel.forecastWeather
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
        view.backgroundColor = .white
        indicator.hide()
        let errorUIView = ErrorView(viewmodel: viewmodel)
        let hostingController = UIHostingController(rootView: errorUIView)
        
        let errorView = hostingController.view!
        errorView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupMainForecastView(currentWeather: WeatherResponse, forecastWeather: ForecastResponse) {
        let backgroundColor = currentWeather.weatherElements.first?.backgroundColorName
        let backgroundImage = currentWeather.weatherElements.first?.imageName
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = UIColor(named: backgroundColor!)
        let backgroundImageView = getImageView()
        backgroundImageView.image = UIImage(named: backgroundImage!)
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackView = getStackView(axis: .vertical)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let cityLabel = getWeatherLabel(fontSize: 20)
        cityLabel.text = currentWeather.name
        stackView.addArrangedSubview(cityLabel)
        
        let tempLabel = getDegreesLabel(fontSize: 52)
        tempLabel.text = "\(Int(currentWeather.mainElement.temp))°"
        stackView.addArrangedSubview(tempLabel)
        
        let nameLabel = getWeatherLabel(fontSize: 28)
        nameLabel.text = currentWeather.weatherElements.first?.main
        stackView.addArrangedSubview(nameLabel)
        
        let summaryUIView = SummaryView(data: currentWeather.mainElement, backgroundColor: backgroundColor!)
        let hostingController = UIHostingController(rootView: summaryUIView)
        
        let summaryView = hostingController.view!
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        
        view.addSubview(summaryView)
        
        let forecastUIView = ForecastView(data: forecastWeather, backgroundColor: backgroundColor!)
        
        let forecastHC = UIHostingController(rootView: forecastUIView)
        
        let forecastView = forecastHC.view!
        forecastView.translatesAutoresizingMaskIntoConstraints = false
        addChild(forecastHC)
        
        view.addSubview(forecastView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            
            summaryView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            summaryView.heightAnchor.constraint(equalToConstant: 52),
            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            forecastView.topAnchor.constraint(equalTo: summaryView.bottomAnchor),
            forecastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    
    // MARK: - UI Components Methods
    
    func getDegreesLabel(fontSize: CGFloat) -> UILabel {
        let newLabel = ViewComponents.createLabel(
            with: .white, text: "", alignment: .center,
            font: UIFont.systemFont(ofSize: fontSize))
        return newLabel
    }
    
    func getWeatherLabel(fontSize: CGFloat) -> UILabel {
        guard let customFont = UIFont(name: "Axiforma-Regular", size: fontSize) else {
            fatalError("""
               Failed to load the "Axiforma-Regular" font.
""")
        }
        let newLabel = ViewComponents.createLabel(
            with: .white, text: "", alignment: .center,
            font: customFont)
        return newLabel
    }
    
    
    
    func getStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = ViewComponents.createStackView(
            axis, distribution: .fill)
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }
    
    func getImageView() -> UIImageView {
        let imageView = ViewComponents.createImageView()
        return imageView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

