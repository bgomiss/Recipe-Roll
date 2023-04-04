//
//  ProfileVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class ProfileVC: UIViewController {

    let signUpImage         = SignUpImageView(frame: .zero)
    let containerView       = SPContainerView(frame: .zero)
    let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let orLabel             = SPSecondaryTitleLabel(fontSize: 25)
    let dhaLabel            = SPSecondaryTitleLabel(fontSize: 18)
    let signUpField         = SPTextField(placeholder: "Email")
    let continueButton      = SPButton(backgroundColor: .systemMint, title: "Continue")
    let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
    let forgotPassButton    = SPButton(backgroundColor: .clear, title: "Forgot your password?")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(signUpImage)
        signUpImage.frame = view.bounds
        configureContainerView()
        configureGreetingLabel(text: "Hi!")
        configureSignUpField()
        configureContButton()
        configureOrLabel()
        configureDHALabel()
        configureSignUpButton()
        configureforgotPassButton()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    func configureGreetingLabel(text: String?) {
        view.addSubview(greetingLabel)
        greetingLabel.text = text
        greetingLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            greetingLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            greetingLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureSignUpField() {
        view.addSubview(signUpField)
        signUpField.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            signUpField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            signUpField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            signUpField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            signUpField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureContButton() {
        view.addSubview(continueButton)
        continueButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: signUpField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: signUpField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: signUpField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureOrLabel() {
        view.addSubview(orLabel)
        
        orLabel.text = "or"
        orLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            orLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            orLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureDHALabel() {
        view.addSubview(dhaLabel)
        
        dhaLabel.text = "Don't have an account?"
        dhaLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            dhaLabel.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            dhaLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
            dhaLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureSignUpButton() {
        view.addSubview(signupButton)
        signupButton.setTitleColor(.systemGreen, for: .normal)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
            signupButton.leadingAnchor.constraint(equalTo: dhaLabel.trailingAnchor),
            signupButton.centerYAnchor.constraint(equalTo: dhaLabel.centerYAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configureforgotPassButton() {
        view.addSubview(forgotPassButton)
        forgotPassButton.setTitleColor(.systemGreen, for: .normal)
        
        NSLayoutConstraint.activate([
            forgotPassButton.topAnchor.constraint(equalTo: dhaLabel.bottomAnchor, constant: 30),
            forgotPassButton.leadingAnchor.constraint(equalTo: dhaLabel.leadingAnchor),
            forgotPassButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
 }
