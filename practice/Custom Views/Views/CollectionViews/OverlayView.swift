//
//  OverlayView.swift
//  practice
//
//  Created by aycan duskun on 2.04.2023.
//

import UIKit

class OverlayView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.55)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
