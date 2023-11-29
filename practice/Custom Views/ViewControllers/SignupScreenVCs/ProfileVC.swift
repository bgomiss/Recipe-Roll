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
    
    var updateProfileImageClosure: ((UIImage) -> Void)?
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
        fetchProfileData()
        uploadImageButton.addTarget(self, action: #selector(uploadImageButtonTapped), for: .touchUpInside)
        profileVCPresenter = ProfileVCPresenter(profileVC: self)
    }
    
    
    @objc func logoutButtonTapped() {
        profileVCPresenter?.logoutCompleted()
        
    }
    
    
    @objc func uploadImageButtonTapped() {
        profileVCPresenter?.imagePickerPresented()
    }
      
    // MARK: - Firebase Upload Image
    
    
        
        
    
    
    func fetchProfileData() {
            // Fetch user data from Firestore
        guard let  uid = Auth.auth().currentUser?.uid else {
            print("No user is currently signed in")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("No document found for this user")
                return
            }
            
            if let data = document.data(),
               let name = data["name"] as? String,
               let email = data["email"] as? String,
               let profileImageUrl = data["profileImageUrl"] as? String {
               //let bookmarkedRecipes = data["bookmarkedRecipes"] as? [String] {
                self.user = User(uid: uid, name: name, profileImageUrl: profileImageUrl)
                self.nameLabel.text = "Welcome \(name)"
                
                self.emailLabel.text = "Email: \(email)"
                self.profileImageView.downloadImage(fromURL: profileImageUrl)
            }
        }
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
