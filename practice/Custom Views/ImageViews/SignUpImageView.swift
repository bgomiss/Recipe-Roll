//
//  SignUpImage.swift
//  practice
//
//  Created by aycan duskun on 4.04.2023.
//

import UIKit

class SignUpImageView: UIImageView {

    let signUpImage = UIImage(named: "signup")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds = true
        image = signUpImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
