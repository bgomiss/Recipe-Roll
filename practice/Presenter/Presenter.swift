//
//  Presenter.swift
//  practice
//
//  Created by aycan duskun on 26.09.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//protocol AuthPresenterDelegate: AnyObject {
//    
//}

//typealias PresenterDelegate = AuthPresenterDelegate & UIViewController

class AuthPresenter {
    typealias AuthenticationVCType = AuthenticationVC
    typealias WelcomeVCType        = WelcomeVC
    typealias SignUpVCType         = SignUpVC
        
        private weak var authenticationVC: AuthenticationVCType?
        private weak var welcomeVC: WelcomeVCType?
        private weak var signUpVC: SignUpVCType?
        
    init(authenticationVC: AuthenticationVCType?, welcomeVC: WelcomeVCType?, signUpVC: SignUpVCType?) {
            self.authenticationVC = authenticationVC
            self.welcomeVC        = welcomeVC
            self.signUpVC         = signUpVC
        }
//    weak var delegate: AuthPresenterDelegate?
//    public func setViewDelegate(delegate: PresenterDelegate) {
//        self.delegate = delegate
//    }
    func checkIfEmailIsRegistered(email: String) {
        guard let welcomeVC = welcomeVC else { return }
        authenticationVC = welcomeVC.authenticationVC
                                  //completion: ((Bool) -> Void)? = nil) {
        Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
            if let error = error {
                print("Error checking email: \(error.localizedDescription)")
                //completion!(false)
                return
            }
            guard let signInMethods else {
                self.authenticationVC!.didTapContinueButton(emailIsRegistered: false)
                return
            }
            self.authenticationVC!.didTapContinueButton(emailIsRegistered: !signInMethods.isEmpty)
//            if let signInMethods = signInMethods, !signInMethods.isEmpty {
//                //completion!(true)
//                self.authenticationVC?.didTapContinueButton(emailIsRegistered: true)
//            } else {
//                //completion!(false)
//                self.authenticationVC?.didTapContinueButton(emailIsRegistered: false)
//            }
            
        }
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
                    self.authenticationVC!.didCompleteSignUp()
                    //self.delegate?.didCompleteSignUp()
                case .failure(let error):
                    print("Error registering user: \(error.localizedDescription)")
                    // Show an error message
                }
            }
        }
    }
}
