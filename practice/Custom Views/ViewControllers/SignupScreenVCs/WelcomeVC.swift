//
//  WelcomeVC.swift
//  practice
//
//  Created by aycan duskun on 6.04.2023.
//

import UIKit

class WelcomeVC: UIViewController {
    
    let containerView       = SPContainerView(frame: .zero)
    let greetingLabel       = SPTitleLabel(textAlignment: .left, fontSize: 50)
    let orLabel             = SPSecondaryTitleLabel(fontSize: 25)
    let dhaLabel            = SPSecondaryTitleLabel(fontSize: 18)
    let eMailField          = SPTextField(placeholder: "Email")
    let continueButton      = SPButton(backgroundColor: .systemMint, title: "Continue")
    let signupButton        = SPButton(backgroundColor: .clear, title: "Sign up")
    let forgotPassButton    = SPButton(backgroundColor: .clear, title: "Forgot your password?")

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
