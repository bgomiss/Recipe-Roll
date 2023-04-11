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
    let orLabel             = SPSecondaryTitleLabel(fontSize: 25)
    let eMailField          = SPTextField(placeholder: "Email")
    let continueButton      = SPButton(backgroundColor: .systemMint, title: "Continue")
    let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
    let forgotPassButton    = SPButton(backgroundColor: .clear, title: "Forgot your password?")
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
        
        stackView.addArrangedSubviews(eMailField, continueButton, orLabel, signupButton, forgotPassButton)
    }
    
    
    private func layoutUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.textColor = .white
        greetingLabel.text = "Hi!"
        orLabel.text = "or"
        
        continueButton.setTitleColor(.white, for: .normal)
        forgotPassButton.contentHorizontalAlignment = .left
        forgotPassButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        signupButton.attributedButton()
        signupButton.contentHorizontalAlignment = .left
        signupButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            
            greetingLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -25),
            greetingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            eMailField.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20),
            eMailField.heightAnchor.constraint(equalToConstant: 50),
            eMailField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            eMailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            continueButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

}
