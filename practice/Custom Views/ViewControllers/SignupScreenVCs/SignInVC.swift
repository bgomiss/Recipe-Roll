//
//  SignInVC.swift
//  practice
//
//  Created by aycan duskun on 6.04.2023.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {

    let containerView       = SPContainerView(frame: .zero)
    let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let userImage           = UIImageView()
    let usernameLabel       = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let emailLabel          = SPSecondaryTitleLabel(fontSize: 15)
    let passwordField       = SPTextField(placeholder: "Password")
    let signinButton        = SPButton(backgroundColor: .systemMint, title: "Sign in")
    let forgotPassButton    = SPButton(backgroundColor: .clear, title: "Forgot your password?")
    let stackView           = UIStackView()
    var email: String?
    
    weak var coordinator: WelcomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(containerView,greetingLabel)
        containerView.addSubviews(userImage, stackView, usernameLabel, emailLabel)
        configureStackView()
        layoutUI()
        signinButton.addTarget(self, action: #selector(signinButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func signinButtonTapped() {
        guard let email = email else {
            print("Email is empty")
            return
        }
        
        let password = passwordField.text ?? ""
        print(password)
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            print("User Signed In Successfully")
            let profileVC = ProfileVC()
            self.navigationController?.pushViewController(profileVC, animated: true)
            self.navigationItem.hidesBackButton = true
//            profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
//            self.navigationController?.setViewControllers([profileVC], animated: true)
        }
    }
    
    
    func updateEmailLabel(with email: String?) {
        if let email = email {
            emailLabel.text = "\(email)"
        } else {
            emailLabel.text = ""
        }
    }
    
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubviews(passwordField, signinButton, forgotPassButton)
    }
    
    
    private func layoutUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        greetingLabel.textColor = .white
        greetingLabel.text = "Sign in"
        userImage.image = UIImage(systemName: "person.circle")
        usernameLabel.text = "Sevket-i Bostan"
        usernameLabel.textColor = .white
        //emailLabel.text = "\(email)"
        emailLabel.textColor = .white
        
        signinButton.setTitleColor(.white, for: .normal)
        forgotPassButton.contentHorizontalAlignment = .left
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            
            greetingLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -25),
            greetingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            userImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            userImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            userImage.heightAnchor.constraint(equalToConstant: 60),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            usernameLabel.centerYAnchor.constraint(equalTo: userImage.centerYAnchor, constant: -10),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            emailLabel.heightAnchor.constraint(equalToConstant: 15),
            emailLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            signinButton.heightAnchor.constraint(equalToConstant: 50),
            signinButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            signinButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            forgotPassButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 110),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }


}
