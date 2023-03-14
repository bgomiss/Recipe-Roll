//
//  UIView+Ext.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
