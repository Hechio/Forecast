//
//  ActivityIndicator.swift
//  Forecast
//
//  Created by Steve Hechio on 25/08/2023.
//

import Foundation
import UIKit

class ActivityIndicator {
    static let shared = ActivityIndicator()
    
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.color = UIColor(named: "AccentColor")
    }
    
    func show(in view: UIView) {
        if let indicator = activityIndicator {
            indicator.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicator)
            
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            indicator.startAnimating()
        }
    }
    
    func hide() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
}
