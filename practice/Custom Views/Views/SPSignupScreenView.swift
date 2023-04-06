//
//  SPSignupScreenView.swift
//  practice
//
//  Created by aycan duskun on 6.04.2023.
//

import UIKit

class SPSignupScreenView: UIView {
    
    enum ScreenType {
        case welcome, signup, signin
    }

    let signUpImage         = SignUpImageView(frame: .zero)
    let containerView       = SPContainerView(frame: .zero)
    let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let orLabel             = SPSecondaryTitleLabel(fontSize: 25)
    let dhaLabel            = SPSecondaryTitleLabel(fontSize: 18)
    let signUpField         = SPTextField(placeholder: "Email")
    let continueButton      = SPButton(backgroundColor: .systemMint, title: "Continue")
    let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
    let forgotPassButton    = SPButton(backgroundColor: .clear, title: "Forgot your password?")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(signUpImage, containerView, greetingLabel, orLabel, dhaLabel, signUpField, continueButton, signupButton, forgotPassButton)
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
