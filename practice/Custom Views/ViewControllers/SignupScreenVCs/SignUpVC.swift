//
//  SignUpVC.swift
//  practice
//
//  Created by aycan duskun on 6.04.2023.
//

import UIKit

class SignUpVC: UIViewController {

    let containerView       = SPContainerView(frame: .zero)
    let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let warningLabel        = SPSecondaryTitleLabel(fontSize: 20)
    let eMailField          = SPTextField(placeholder: "Email")
    let passwordField       = SPTextField(placeholder: "Password")
    let signupButton        = SPButton(backgroundColor: .systemMint, title: "Sign up")
    
    let stackView           = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(containerView,greetingLabel)
        containerView.addSubviews(stackView)
        configureStackView()
        layoutUI()
        
    }
    
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubviews(warningLabel, eMailField, passwordField, signupButton)
    }
    
    
    private func layoutUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.textColor = .white
        greetingLabel.text = "Sign up"
        
        warningLabel.textColor = .white
        warningLabel.text = "Looks like you don't have an account. Let's create a new account for abc@gmail.com"
        
    
        signupButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            
            greetingLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -25),
            greetingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            warningLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            eMailField.heightAnchor.constraint(equalToConstant: 50),
            eMailField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            eMailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            signupButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            signupButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

}
