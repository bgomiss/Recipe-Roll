//
//  SPSecondaryTitleLabel.swift
//  practice
//
//  Created by aycan duskun on 15.03.2023.
//

import UIKit

class SPSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat, color: UIColor? = nil, weight: UIFont.Weight? = nil) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: weight ?? .light)
       textColor = color
        
    }
    
    
    private func configure() {
        textColor = .white
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }

}

