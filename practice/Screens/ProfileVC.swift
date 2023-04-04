//
//  ProfileVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class ProfileVC: UIViewController {

    let signUpImage = SignUpImageView(frame: .zero)
    let overlayView = OverlayView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(signUpImage, overlayView)
        signUpImage.frame = view.bounds
//        overlayView.frame = view.bounds
        
    }
 }
