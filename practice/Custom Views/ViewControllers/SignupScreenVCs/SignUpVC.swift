//
//  SignUpVC.swift
//  practice
//
//  Created by aycan duskun on 6.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//protocol SignUpVCDelegate: AnyObject {
//    func didCompleteSignUp()
//}

class SignUpVC: UIViewController {

    let containerView       = SPContainerView(frame: .zero)
    let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let warningLabel        = SPSecondaryTitleLabel(fontSize: 20)
    let nameField           = SPTextField(placeholder: "Name")
    let eMailField          = SPTextField(placeholder: "Email")
    let passwordField       = SPTextField(placeholder: "Password")
    let signupButton        = SPButton(backgroundColor: .systemMint, title: "Sign up")
    let stackView           = UIStackView()
    var email: String?
    
    //weak var delegate: SignUpVCDelegate?
    private var presenter: AuthPresenter?
    private var signUpPresenter: SignUpPresenter?
    weak var authenticationVC: AuthenticationVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(containerView,greetingLabel)
        containerView.addSubviews(stackView)
        configureStackView()
        layoutUI()
        presenter = AuthPresenter(authenticationVC: nil, welcomeVC: nil)
        signUpPresenter = SignUpPresenter(signUpVC: self, authenticationVC: nil)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    
//    func registerNewUser(name: String, email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//                let userData: [String: Any] = [
//                    "name": name,
//                    "email": email,
//                ]
//                
//                let db = Firestore.firestore()
//                db.collection("users").document(authResult!.user.uid).setData(userData) { error in
//                    if let error = error {
//                        print("Error saving user data: \(error.localizedDescription)")
//                        
//                    } else {
//                        print("User data saved successfully")
//                    }
//                }
//                completion(.success(authResult!))
//            }
//        }
        
    
    func updateWarningLabel(with email: String?) {
            if let email = email {
                warningLabel.text = "Looks like you don't have an account. Let's create a new account for \(email)"
            } else {
                warningLabel.text = "Looks like you don't have an account. Let's create a new account."
            }
        }
    
    
    @objc func signupButtonTapped() {
        // Validate and get the email and password
//        guard let email = eMailField.text, !email.isEmpty,
//              let password = passwordField.text, !password.isEmpty,
//              let name = nameField.text, !name.isEmpty else {
//            print("Name, Email or password is empty")
//            return
//        }
        // Call the registerNewUser function with the email and password
        signUpPresenter?.signUpCompleted()
//        registerNewUser(name: name, email: email, password: password) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let authResult):
//                    print("User registered successfully: \(authResult.user.uid)")
//                    // Navigate to the next screen or show a success message
//                    //self.delegate?.didCompleteSignUp()
//                case .failure(let error):
//                    print("Error registering user: \(error.localizedDescription)")
//                    // Show an error message
//                }
//            }
//        }
        
    }
    
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubviews(warningLabel, nameField, eMailField, passwordField, signupButton)
    }
    
    
    private func layoutUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.textColor = .white
        greetingLabel.text = "Sign up"
        
        warningLabel.textColor = .white
            
        signupButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            
            greetingLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -25),
            greetingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            warningLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            nameField.heightAnchor.constraint(equalToConstant: 50),
            nameField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
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
