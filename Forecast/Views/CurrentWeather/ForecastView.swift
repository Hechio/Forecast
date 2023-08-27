//
//  ForecastView.swift
//  Forecast
//
//  Created by Steve Hechio on 24/08/2023.
//

import SwiftUI

struct ForecastView: View {
    let data: ForecastResponse
    let backgroundColor: String
  
    var body: some View {
        VStack{
            
            Divider()
                .frame(height: 1.2)
                .overlay(Color.white)
            
            ScrollView {
                ForEach(data.forecastList) { item in
                    ForecastCell(forecast: item)
                }
            }
        }.background(Color(backgroundColor))
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(data: ForecastResponse.emptyInit(), backgroundColor: "SunnyColor")
            .frame(height: 20)
    }
}

struct ForecastCell: View {
    let forecast: ForecastWeather
    
    var body: some View {
        HStack {
            Text(day)
                .foregroundColor(.white)
                .font(Font.custom("Axiforma-Medium", size: 18))
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                .frame(width: 140, alignment: .leading)
            
            Spacer().frame(width: 36)
            
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .frame(width: 30, height: 30)
            
            Spacer()
            
            Text(temp)
                .foregroundColor(.white)
                .font(.headline)
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
        }
        .frame(height: 52)
        .background(Color.clear)
    }
    
    var day: String {
        return forecast.date.dateFromMilliseconds().day()
    }
    
    var temp: String {
        return "\(Int(forecast.mainElement.temp))°"
    }
    
    var icon: String {
        if let weather = forecast.elements.first {
            return weather.iconImage
        }
        return "clear"
    }
}

