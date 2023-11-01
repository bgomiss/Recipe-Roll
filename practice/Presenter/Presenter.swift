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
    
        
        private weak var authenticationVC: AuthenticationVCType?
        private weak var welcomeVC: WelcomeVC?
        
        
    init(authenticationVC: AuthenticationVCType?, welcomeVC: WelcomeVC?) {
            self.authenticationVC = authenticationVC
            self.welcomeVC        = welcomeVC
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
                self.authenticationVC?.didTapContinueButton(emailIsRegistered: false)
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
}
