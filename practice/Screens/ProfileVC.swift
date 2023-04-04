//
//  ProfileVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class ProfileVC: UIViewController {

    let signUpImage     = SignUpImageView(frame: .zero)
    let containerView   = SPContainerView(frame: .zero)
    let greetingLabel   = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let orLabel         = SPSecondaryTitleLabel(fontSize: 25)
    let signUpField     = SPTextField(placeholder: "Email")
    let continueButton  = SPButton(backgroundColor: .systemMint, title: "Continue")
    
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
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 450)
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
 }
