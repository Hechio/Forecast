//
//  ViewComponents.swift
//  Forecast
//
//  Created by Steve Hechio on 24/08/2023.
//

import Foundation
import UIKit
import SwiftUI
struct ViewComponents {
    
    static func createLabel(with color: UIColor, text: String, alignment: NSTextAlignment, font: UIFont) -> UILabel {
        
        let newLabel = UILabel()
        newLabel.textColor = color
        newLabel.text = text
        newLabel.textAlignment = alignment
        newLabel.font = font
        newLabel.adjustsFontSizeToFitWidth = true
        return newLabel
    }
    
    static func createStackView(_ axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = .center
        return stackView
    }
    
    static func createEmptyView() -> UIView {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }
    
    static func createImageView() -> UIImageView {
        let newImageView = UIImageView()
        newImageView.contentMode = .scaleAspectFill
        newImageView.backgroundColor = .clear
        newImageView.clipsToBounds = true
        return newImageView
    }
    
}

func createLabel(with color: Color, text: String, alignment: TextAlignment, font: Font) -> Text {
    return Text(text)
        .foregroundColor(color)
        .font(font)
}

