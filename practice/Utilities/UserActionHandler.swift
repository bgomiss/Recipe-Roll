//
//  UserActionHandler.swift
//  practice
//
//  Created by aycan duskun on 16.05.2023.
//

import UIKit
import FirebaseAuth

class UserActionHandler {
    static func userTriedToBookmarkOrComment(in viewController: UIViewController) {
        if !isUserSignedIn() {
            showAlertAndDirectToProfile(in: viewController)
        } else {
            
        }
    }
    
    
    static func isUserSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    
    static func showAlertAndDirectToProfile(in viewController: UIViewController) {
        viewController.presentSPAlertOnMainThread(title: "Attention", message: "Please signUp/signIn to perform this action", buttonTitle: "OK")
    }
}
