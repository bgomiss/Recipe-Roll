//
//  SignUpPresenter.swift
//  practice
//
//  Created by aycan duskun on 31.10.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpPresenter {
    
    private weak var signUpVC: SignUpVC?
    private weak var authenticationVC: AuthenticationVC?
    
    init(signUpVC: SignUpVC?, authenticationVC: AuthenticationVC?) {
        self.signUpVC         = signUpVC
        self.authenticationVC = authenticationVC
    }
    
    func registerNewUser(name: String, email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
                let userData: [String: Any] = [
                    "name": name,
                    "email": email,
                ]
                
                let db = Firestore.firestore()
                db.collection("users").document(authResult!.user.uid).setData(userData) { error in
                    if let error = error {
                        print("Error saving user data: \(error.localizedDescription)")
                        
                    } else {
                        print("User data saved successfully")
                    }
                }
                completion(.success(authResult!))
            }
        }
    
    func signUpCompleted() {
        guard let email = signUpVC?.eMailField.text, !email.isEmpty,
              let password = signUpVC?.passwordField.text, !password.isEmpty,
              let name = signUpVC?.nameField.text, !name.isEmpty
        else { print("Name, Email or password is empty")
             return }
        
        registerNewUser(name: name, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authResult):
                    print("User registered successfully: \(authResult.user.uid)")
                    
                    // Navigate to the next screen or show a success message
                    guard let authenticationVC = self.signUpVC?.authenticationVC else { return }
                    authenticationVC.didCompleteSignUp()
                    //self.delegate?.didCompleteSignUp()
                case .failure(let error):
                    print("Error registering user: \(error.localizedDescription)")
                    // Show an error message
                }
            }
        }
    }
}
