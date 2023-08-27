//
//  ErrorView.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import SwiftUI

struct ErrorView: View {
    let viewmodel: WeatherViewModel
    
    var body: some View {
        VStack{
            Button(action: {
                self.viewmodel.retry()
            })
            {
                Text("Failed get data, retry?")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewmodel: WeatherViewModel())
    }
}
