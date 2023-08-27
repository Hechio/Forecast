//
//  CustomCalloutView.swift
//  Forecast
//
//  Created by Steve Hechio on 27/08/2023.
//

import SwiftUI

struct CustomCalloutView: View {
    let cityName: String
    let temperature: String

    var body: some View {
        VStack {
            Text("\(temperature)°")
                .font(.largeTitle)
            Text(cityName)
                .font(.custom("Axiforma-Medium", size: 16))
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
