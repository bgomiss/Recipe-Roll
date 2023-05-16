//
//  ProfileVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class ProfileVC: UIViewController {

    let signUpImage         = SignUpImageView(frame: .zero)
    let signUpField         = SPTextField(placeholder: "Email")
    let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
    let welcomeVC           = WelcomeVC()
    let signUpVC            = SignUpVC()
    let signinVC            = SignInVC()
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(signUpImage)
        signUpImage.frame = view.bounds
        configureUIElements()
     }
    
    
    func showAuthenticationFlow() {
        (coordinator as? AppCoordinator)?.startAuthenticationFlow(from: self)
    }

    
   
    func configureUIElements() {
        signUpVC.view.isHidden = true
        welcomeVC.view.isHidden = false
        signinVC.view.isHidden = true
        welcomeVC.delegate = self
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

extension ProfileVC: WelcomeVCDelegate {
    func didTapContinueButton(emailIsRegistered: Bool) {
        for child in children {
            if let welcomeVC = child as? WelcomeVC {
                welcomeVC.view.isHidden = true
            } else if let signUpVC = child as? SignUpVC {
                if !emailIsRegistered {
                    signUpVC.view.isHidden = false
                }
            } else if let signInVC = child as? SignInVC {
                if emailIsRegistered {
                    signInVC.view.isHidden = false
                }
            }
        }
    }
}
