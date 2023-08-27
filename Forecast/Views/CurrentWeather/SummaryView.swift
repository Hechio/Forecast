//
//  SummaryView.swift
//  Forecast
//
//  Created by Steve Hechio on 24/08/2023.
//

import SwiftUI

struct SummaryView: View {
    let data: MainWeatherElement
    let backgroundColor: String
    
    var tempCurrent: String {
        return "\(Int(data.temp))°"
    }
    
    var tempMax: String {
        return "\(Int(data.tempMax))°"
    }
    
    var tempMin: String {
        return "\(Int(data.tempMin))°"
    }
    
    
    var body: some View {
        HStack{
            SummaryColumn(value: tempMin, desc: "min")
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            Spacer()
            
            SummaryColumn(value: tempCurrent, desc: "Current")
            Spacer()
            
            SummaryColumn(value: tempMax, desc: "max")
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 52)
        .background(Color(backgroundColor))
    }
}



#if DEBUG
struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(data: MainWeatherElement.emptyInit(), backgroundColor: "SunnyColor")
    }
}
#endif
