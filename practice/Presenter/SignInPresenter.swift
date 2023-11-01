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
}
