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
    let profileVC = ProfileVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(signUpImage)
        signUpImage.frame = view.bounds
        configureUIElements()

     }
    
    
    func resetToWelcomeScreen() {
        // Logic to switch to WelcomeVC
        for child in children {
                if let welcomeVC = child as? WelcomeVC {
                    welcomeVC.view.isHidden = false
                } else if let signUpVC = child as? SignUpVC {
                    signUpVC.view.isHidden = true
                } else if let signInVC = child as? SignInVC {
                    signInVC.view.isHidden = true
                }
            }
    }

    
   
    func configureUIElements() {
        signUpVC.view.isHidden = true
        welcomeVC.view.isHidden = false
        signinVC.view.isHidden = true
        welcomeVC.delegate = self
        signUpVC.delegate = self
        profileVC.delegate = self
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
    }
}

extension AuthenticationVC: SignoutDelegate {
    func didCompleteSignOut() {
        // Get a reference to the AppDelegate or SceneDelegate from the current context
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }// or SceneDelegate
        // Call the function to reset the window's rootViewController
        sceneDelegate.showMainApp()
        //    func didCompleteSignOut() {
        //        //        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        //        //        sceneDelegate.showMainApp()
        //        //    }
        //        for child in children {
        //            if let welcomeVC = child as? WelcomeVC {
        //                welcomeVC.view.isHidden = false
        //            } else if let signUpVC = child as? SignUpVC {
        //                signUpVC.view.isHidden = true
        //            } else if let signInVC = child as? SignInVC {
        //                signInVC.view.isHidden = true
        //            }
        //        }
        //    }
        
    }
}
