//
//  WelcomeVC.swift
//  practice
//
//  Created by aycan duskun on 6.04.2023.
//

import UIKit
import FirebaseAuth

//protocol WelcomeVCDelegate: AnyObject {
//    func didTapContinueButton(emailIsRegistered: Bool)
//}

class WelcomeVC: UIViewController {

    
    //let containerView       = SPContainerView(frame: .zero)
        private lazy var containerView: SPContainerView = {
            return SPContainerView(frame: .zero)
        }()
        //let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
        private lazy var greetingLabel: SPTitleLabel = {
            return SPTitleLabel(textAlignment: .left, fontSize: 50)
        }()
        //let orLabel             = SPSecondaryTitleLabel(fontSize: 25)
        private lazy var orLabel: SPSecondaryTitleLabel = {
            return SPSecondaryTitleLabel(fontSize: 25)
        }()
        //let eMailField          = SPTextField(placeholder: "Email")
        public lazy var eMailField: SPTextField = {
            return SPTextField(placeholder: "Email")
        }()
        //let continueButton      = SPButton(backgroundColor: .systemMint, title: "Continue")
        private lazy var continueButton: SPButton = {
            return SPButton(backgroundColor: .systemMint, title: "Continue")
        }()
        //let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
        private lazy var signupButton: SPButton = {
            return SPButton(backgroundColor: .clear, title: "Sign up")
        }()
        //let forgotPassButton    = SPButton(backgroundColor: .clear, title: "Forgot your password?")
        private lazy var forgotPassButton: SPButton = {
            return SPButton(backgroundColor: .clear, title: "Forgot your password?")
        }()
        //let stackView           = UIStackView()
        private lazy var stackView: UIStackView = {
            return UIStackView()
        }()
    
//    weak var delegate: WelcomeVCDelegate?
    private var presenter: AuthPresenter?
    weak var authenticationVC: AuthenticationVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(containerView,greetingLabel)
        containerView.addSubviews(stackView)
        configureStackView()
        layoutUI()
        presenter = AuthPresenter(authenticationVC: nil, welcomeVC: self, signUpVC: nil)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc func continueButtonTapped() {
        presenter?.checkIfEmailIsRegistered(email: eMailField.text ?? "") 
//        { isRegistered in
//            if isRegistered {
//                print("Email is registered")
//            } else {
//                print("Email is not registered")
//            }
//            self.authenticationVC?.didTapContinueButton(emailIsRegistered: isRegistered)
//            //self.delegate?.didTapContinueButton(emailIsRegistered: isRegistered)
//        }
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
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
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
