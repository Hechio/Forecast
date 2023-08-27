//
//  FavoritesListView.swift
//  Forecast
//
//  Created by Steve Hechio on 26/08/2023.
//

import SwiftUI

struct FavoritesListView: View {
    let favoriteList: [WeatherResponse]
    var body: some View {
        VStack {
            ScrollView{
                ForEach(favoriteList, id: \.name) { item in
                   FavoriteCell(data: item)
                }
            }
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        let list = [WeatherResponse(id: 200, coordinate: Coordinate(lon: 180.0, lat: 180.0), weatherElements: [WeatherElement(id: 1, main: "Clouds", elementDescription: "Few Cloud", icon: "")], mainElement: MainWeatherElement(temp: 27.6, feelsLike: 27, tempMin: 27.5, tempMax: 27.6, pressure: 6, humidity: 7), date: 16666000098, name: "Nairobi", code: 500),WeatherResponse(id: 200, coordinate: Coordinate(lon: 180.0, lat: 180.0), weatherElements: [WeatherElement(id: 1, main: "Clouds", elementDescription: "Few Cloud", icon: "")], mainElement: MainWeatherElement(temp: 27.6, feelsLike: 27, tempMin: 27.5, tempMax: 27.6, pressure: 6, humidity: 7), date: 16666000098, name: "Nairobi", code: 500),WeatherResponse(id: 200, coordinate: Coordinate(lon: 180.0, lat: 180.0), weatherElements: [WeatherElement(id: 1, main: "Clouds", elementDescription: "Few Cloud", icon: "")], mainElement: MainWeatherElement(temp: 27.6, feelsLike: 27, tempMin: 27.5, tempMax: 27.6, pressure: 6, humidity: 7), date: 16666000098, name: "Nairobi", code: 500)]
        FavoritesListView(favoriteList: list)
    }
}
