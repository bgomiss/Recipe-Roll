//
//  StackView+Ext.swift
//  practice
//
//  Created by aycan duskun on 9.04.2023.
//

import UIKit

extension UIStackView {
    
    func addSubviews(_ views: UIStackView...) {
        for view in views { addArrangedSubview(view) }
    }
}
