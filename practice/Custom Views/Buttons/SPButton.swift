//
//  SPButton.swift
//  practice
//
//  Created by aycan duskun on 15.03.2023.
//

import UIKit

class SPButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.systemGreen, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(withColor color: UIColor = .systemGreen, backgroundColor: UIColor, title: String = "") {
        self.backgroundColor = backgroundColor
        setTitleColor(color, for: .normal)
        setTitle(title, for: .normal)
    }
    
    func attributedButton() {

        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign Up",
                                                         attributes: [.font: UIFont.systemFont(ofSize: 18)])

        let range = NSRange(location: 22, length: 8)
        attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: range)

        setAttributedTitle(attributedString, for: .normal)
    }
}
