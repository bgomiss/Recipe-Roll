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
    
    func setUp(to superView: UIView, and to: UITextField) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: to.bottomAnchor, constant: 10).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
}
