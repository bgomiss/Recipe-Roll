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
    
    
   convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
       font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        
    }
    
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}

