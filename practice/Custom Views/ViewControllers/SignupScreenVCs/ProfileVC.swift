//
//  ProfileVC.swift
//  practice
//
//  Created by aycan duskun on 31.05.2023.
//

import UIKit
import Firebase

import FirebaseFirestore
import PhotosUI

class ProfileVC: UIViewController {
    
    
    var profileImageView = SPImageView(cornerRadius: 50)
    var nameLabel = SPTitleLabel(textAlignment: .center, fontSize: 24)
    var emailLabel = SPSecondaryTitleLabel(fontSize: 18, color: .black)
    lazy var uploadImageButton: SPButton = {
            let button = SPButton()
            button.set(withColor: .white, backgroundColor: .systemGray, title: "Upload Image")
            return button
        }()
    
    lazy var logoutButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "power"), style: .plain, target: self, action: #selector(logoutButtonTapped))
    }()
    
    var user: User?
    private var profileVCPresenter: ProfileVCPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = logoutButton
        setupConstraints()
        profileVCPresenter = ProfileVCPresenter(profileVC: self)
        profileVCPresenter?.fetchProfileData()
        uploadImageButton.addTarget(self, action: #selector(uploadImageButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc func logoutButtonTapped() {
        profileVCPresenter?.logoutCompleted()
        
    }
    
    
    @objc func uploadImageButtonTapped() {
        profileVCPresenter?.imagePickerPresented()
    }
      
    
    func setupConstraints() {
        view.addSubviews(profileImageView, nameLabel, emailLabel, uploadImageButton)
        
        
            NSLayoutConstraint.activate([
                profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                profileImageView.widthAnchor.constraint(equalToConstant: 100),
                profileImageView.heightAnchor.constraint(equalToConstant: 100),

                nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                nameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 20),

                emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10),
                
                uploadImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                uploadImageButton.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 20)
            ])
        }
}
