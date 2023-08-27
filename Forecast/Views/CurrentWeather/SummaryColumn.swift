//
//  SummaryColumn.swift
//  Forecast
//
//  Created by Steve Hechio on 24/08/2023.
//

import SwiftUI

struct SummaryColumn: View {
    let value:String
    let desc: String
    
    init(value: String, desc: String) {
        self.value = value
        self.desc = desc
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            createLabel(with: .white, text: value, alignment: .center, font: .headline)
            
            Spacer(minLength: 4)
            createLabel(with: .white, text: desc, alignment: .center, font: Font.custom("Axiforma-Regular", size: 14))
            Spacer(minLength: 4)
            
        }.frame(maxHeight: 52, alignment: .center)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        
    }
    
}

struct SummaryColumn_Previews: PreviewProvider {
    static var previews: some View {
        SummaryColumn(value: "20", desc: "Min").background(Color(.green))
    }
}
