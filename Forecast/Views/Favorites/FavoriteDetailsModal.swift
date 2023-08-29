//
//  FavoriteDetailsModal.swift
//  Forecast
//
//  Created by Steve Hechio on 29/08/2023.
//

import SwiftUI

struct FavoriteDetailsModal: View {
    @Binding var favCurrentWeather: WeatherResponse?
    
    var body: some View {
        CurrentUIViewControllerRepresentable(favCurrentWeather: $favCurrentWeather)
    }
}

struct CurrentUIViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var favCurrentWeather: WeatherResponse?
    
    func makeUIViewController(context: Context) -> CurrentViewController {
        let viewController = CurrentViewController()
        viewController.showFavDetails = true
        viewController.favCurrentWeather = favCurrentWeather ?? WeatherResponse.emptyInit()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CurrentViewController, context: Context) {
        uiViewController.favCurrentWeather = favCurrentWeather ?? WeatherResponse.emptyInit()
    }
}
