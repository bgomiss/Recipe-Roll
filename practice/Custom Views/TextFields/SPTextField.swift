//
//  SPTextField.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import UIKit

class SPTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(placeholder: String?) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label //White in dark mode, black in light mode
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .search
        clearButtonMode = .whileEditing
    }
}
