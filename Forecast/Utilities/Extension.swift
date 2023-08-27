//
//  Extension.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation

extension Int {
    func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Date {
    func day() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func time() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    func dateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd MMM yyyy hh:mma"
        return dateFormatter.string(from: self)
    }
    
    
}


