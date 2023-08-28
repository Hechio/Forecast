//
//  FavoritesCell.swift
//  Forecast
//
//  Created by Steve Hechio on 26/08/2023.
//

import SwiftUI

struct FavoriteCell: View {
    let data: WeatherResponse
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                VStack(alignment: .leading, spacing: 4){
                    Text(data.name)
                        .foregroundColor(.white)
                        .font(.custom("Axiforma-Bold", size: 20))
                    Text(data.date.dateFromMilliseconds().time()).foregroundColor(.white)
                        .font(.custom("Axiforma-Bold", size: 12))
                }
                Spacer()
                Text("\(Int(data.mainElement.temp))°")
                    .foregroundColor(.white)
                    .font(.largeTitle).bold()
                
            }.padding(8)
            
            HStack {
                Text(data.weatherElements.first?.elementDescription ?? "")
                    .foregroundColor(.white)
                    .font(.custom("Axiforma-Bold", size: 12))
                    .padding(8)
                Spacer()
                
                Text("H:\(Int(data.mainElement.tempMax))° L:\(Int(data.mainElement.tempMin))°")
                    .foregroundColor(.white)
                    .font(.custom("Axiforma-Bold", size: 12))
                    .padding(8)
                
            }
            VStack(alignment: .leading) {
                Text("Last Update: \(data.lastUpdate?.dateFromMilliseconds().dateTime() ?? "Now")")
                    .foregroundColor(.white)
                    .frame(alignment: .trailing)
                    .font(.custom("Axiforma-Regular", size: 12))

            }.padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
            
        }.background(Color.accentColor)
            .cornerRadius(12)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct FavoritesCell_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCell(data: WeatherResponse(id: 200, coordinate: Coordinate(lon: 180.0, lat: 180.0), weatherElements: [WeatherElement(id: 1, main: "Clouds", elementDescription: "Few Cloud", icon: "")], mainElement: MainWeatherElement(temp: 27.6, feelsLike: 27, tempMin: 27.5, tempMax: 27.6, pressure: 6, humidity: 7), date: 16666000098, name: "Nairobi", code: 500))
    }
}
