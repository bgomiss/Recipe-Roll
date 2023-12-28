//
//  SignInPresenter.swift
//  practice
//
//  Created by aycan duskun on 1.11.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignInPresenter {
    
    private weak var signInVC: SignInVC?
    private weak var authenticationVC: AuthenticationVC?
    
    init(signInVC: SignInVC?, authenticationVC: AuthenticationVC?) {
        self.signInVC         = signInVC
        self.authenticationVC = authenticationVC
    }
    
    func signInCompleted() {
        guard let email = signInVC?.email else {
            print("Email is empty")
            return
        }
        
        let password = signInVC?.passwordField.text ?? ""
        print(password)
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            print("User Signed In Successfully")
           
            signInVC?.navigationController?.pushViewController(SignInVC.profileVC, animated: true)
            SignInVC.profileVC.navigationItem.hidesBackButton = true
            
//            profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
//            self.navigationController?.setViewControllers([profileVC], animated: true)
        }
    }
}
