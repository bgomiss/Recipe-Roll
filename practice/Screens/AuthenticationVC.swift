//
//  ProfileVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class AuthenticationVC: UIViewController {

    let signUpImage         = SignUpImageView(frame: .zero)
    let signUpField         = SPTextField(placeholder: "Email")
    let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
    let welcomeVC           = WelcomeVC()
    let signUpVC            = SignUpVC()
    let signinVC            = SignInVC()
    
//    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(signUpImage)
        signUpImage.frame = view.bounds
        configureUIElements()
     }
    
    
//    func showAuthenticationFlow() {
//        (coordinator as? AppCoordinator)?.startAuthenticationFlow(from: self)
//    }

    
   
    func configureUIElements() {
        signUpVC.view.isHidden = true
        welcomeVC.view.isHidden = false
        signinVC.view.isHidden = true
        welcomeVC.delegate = self
        signUpVC.delegate = self
        add(childVC: welcomeVC, to: self.view)
        add(childVC: signUpVC, to: self.view)
        add(childVC: signinVC, to: self.view)
    }
  
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
 }

extension AuthenticationVC: WelcomeVCDelegate {
    func didTapContinueButton(emailIsRegistered: Bool) {
        for child in children {
            if let welcomeVC = child as? WelcomeVC {
                welcomeVC.view.isHidden = true
            } else if let signUpVC = child as? SignUpVC {
                if !emailIsRegistered {
                    signUpVC.email = welcomeVC.eMailField.text
                    signUpVC.updateWarningLabel(with: signUpVC.email)
                    signUpVC.view.isHidden = false
                }
            } else if let signInVC = child as? SignInVC {
                if emailIsRegistered {
                    signInVC.email = welcomeVC.eMailField.text
                    signInVC.updateEmailLabel(with: signInVC.email)
                    signInVC.view.isHidden = false
                }
            }
        }
    }
}

extension AuthenticationVC: SignUpVCDelegate {
    func didCompleteSignUp() {
        
        // Get a reference to the AppDelegate or SceneDelegate from the current context
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }// or SceneDelegate
            // Call the function to reset the window's rootViewController
            sceneDelegate.showMainApp()
//        // Handle the completion of the signup here
//        // You can present the profile view controller for example
//        let profileVC = ProfileVC()
//        // Check if the AuthenticationVC is wrapped in a UINavigationController
//        if let navigationController = navigationController {
//            navigationController.pushViewController(profileVC, animated: true)
//        } else {
//            // If it is not wrapped, you can wrap it here or consider other navigation methods
//            // such as presenting the profileVC modally
//            let navigationController = UINavigationController(rootViewController: profileVC)
//            present(navigationController, animated: true, completion: nil)
        }
    
//    func didCompleteSignOut() {
//        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
//        sceneDelegate.showMainApp()
//    }
    }

