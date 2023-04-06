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
    
    let containerView       = SPContainerView(frame: .zero)
    let signUpImage         = SignUpImageView(frame: .zero)
    let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let warningLabel        = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let orLabel             = SPSecondaryTitleLabel(fontSize: 25)
    let dhaLabel            = SPSecondaryTitleLabel(fontSize: 18)
    let eMailField          = SPTextField(placeholder: "Email")
    let passwordField       = SPTextField(placeholder: "Password")
    let continueButton      = SPButton(backgroundColor: .systemMint, title: "Continue")
    let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
    let forgotPassButton    = SPButton(backgroundColor: .clear, title: "Forgot your password?")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.set(screenType: .welcome)
        self.set(screenType: .signin)
        self.set(screenType: .signup)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureGreetingLabel() {
        addSubview(greetingLabel)
        greetingLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            greetingLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            greetingLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
        
    }
    
    private func configureEmailField() {
        addSubview(eMailField)
        
        NSLayoutConstraint.activate([
            eMailField.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            eMailField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            eMailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            eMailField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureContinueButton() {
        addSubview(continueButton)
        continueButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: eMailField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: eMailField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: eMailField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func connfigureOrLabel() {
        addSubview(orLabel)
        
        orLabel.text = "or"
        orLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            orLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            orLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureDhaLabel() {
        addSubview(dhaLabel)
        
        dhaLabel.text = "Don't have an account?"
        dhaLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            dhaLabel.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            dhaLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
            dhaLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureSignUpButton() {
        addSubview(signupButton)
        signupButton.setTitleColor(.systemGreen, for: .normal)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
            signupButton.leadingAnchor.constraint(equalTo: dhaLabel.trailingAnchor),
            signupButton.centerYAnchor.constraint(equalTo: dhaLabel.centerYAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func configureForgotPassButton() {
        addSubview(forgotPassButton)
        forgotPassButton.setTitleColor(.systemGreen, for: .normal)
        
        NSLayoutConstraint.activate([
            forgotPassButton.topAnchor.constraint(equalTo: dhaLabel.bottomAnchor, constant: 30),
            forgotPassButton.leadingAnchor.constraint(equalTo: dhaLabel.leadingAnchor),
            forgotPassButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func configureWarningLabel() {
        addSubview(warningLabel)
        
        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            warningLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            warningLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configure(bottomConstant: CGFloat, containerHeight: CGFloat) {
        addSubviews(signUpImage, containerView)
        
        signUpImage.frame = bounds
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomConstant),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: containerHeight),
        ])
    }
    
    func set(screenType: ScreenType) {
        switch screenType {
        case .welcome:
            configure(bottomConstant: 100, containerHeight: 350)
            configureGreetingLabel()
            configureEmailField()
            configureContinueButton()
            connfigureOrLabel()
            configureDhaLabel()
            configureSignUpButton()
            
            greetingLabel.text = "Hi!"
            
            
            
        case.signup:
            configureWarningLabel()
            
            greetingLabel.text = "Sign up"
            
        case .signin:
            greetingLabel.text = "Sign in"
        }
        
    }
}
