//
//  Presenter.swift
//  practice
//
//  Created by aycan duskun on 26.09.2023.
//

import UIKit
import FirebaseAuth

//protocol AuthPresenterDelegate: AnyObject {
//    
//}

//typealias PresenterDelegate = AuthPresenterDelegate & UIViewController

class AuthPresenter {
    typealias AuthenticationVCType = AuthenticationVC
    typealias WelcomeVCType = WelcomeVC
        
        private weak var authenticationVC: AuthenticationVCType?
        private weak var welcomeVC: WelcomeVCType?
        
        init(authenticationVC: AuthenticationVCType?, welcomeVC: WelcomeVCType?) {
            self.authenticationVC = authenticationVC
            self.welcomeVC = welcomeVC
        }
//    weak var delegate: AuthPresenterDelegate?
//    public func setViewDelegate(delegate: PresenterDelegate) {
//        self.delegate = delegate
//    }
    func checkIfEmailIsRegistered(email: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
            if let error = error {
                print("Error checking email: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let signInMethods = signInMethods, !signInMethods.isEmpty {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
