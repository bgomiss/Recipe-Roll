//
//  ProfileVC.swift
//  practice
//
//  Created by aycan duskun on 31.05.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import PhotosUI

protocol SignoutDelegate: AnyObject {
    func didCompleteSignOut()
}

class ProfileVC: UIViewController, PHPickerViewControllerDelegate {
    
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
    weak var delegate: SignoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = logoutButton
        setupConstraints()
        fetchProfileData()
        uploadImageButton.addTarget(self, action: #selector(uploadImageButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func logoutButtonTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("User signed Out successfully")
            delegate?.didCompleteSignOut()

//            if let authVC = self.navigationController?.viewControllers.first as? AuthenticationVC {
//                authVC.resetToWelcomeScreen()
            
            } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
    
    @objc func uploadImageButtonTapped() {
        // Use PHPickerViewController
               var configuration = PHPickerConfiguration()
               configuration.selectionLimit = 1
               configuration.filter = .images
               let picker = PHPickerViewController(configuration: configuration)
               picker.delegate = self
               present(picker, animated: true, completion: nil)
    }
    
    
    // MARK: - PHPickerViewControllerDelegate Methods
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            dismiss(animated: true, completion: nil)

            guard let itemProvider = results.first?.itemProvider, 
                      itemProvider.canLoadObject(ofClass: UIImage.self) else { return }

            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                DispatchQueue.main.async {
                    guard let self = self, 
                          let image = image as? UIImage else { return }

                            self.profileImageView.image = image
                            self.updateProfileImageClosure?(image)
                    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
                            self.uploadProfileImageToFirebaseStorage(imageData)
                        }
                    }

                 }
            
        
    
    
    // MARK: - Firebase Upload Image
    
    func uploadProfileImageToFirebaseStorage(_ imageData: Data) {
            guard let uid = Auth.auth().currentUser?.uid else {
                print("No user is currently signed in")
                return
            }
            
            let storageRef = Storage.storage().reference().child("profileImages/\(uid)/profile.jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download url: \(error.localizedDescription)")
                        return
                    }
                    
                    if let downloadUrl = url {
                        self.updateUserProfileImageInFirestore(downloadUrl.absoluteString)
                    }
                }
            }
        }
        
        func updateUserProfileImageInFirestore(_ imageUrl: String) {
            guard let uid = Auth.auth().currentUser?.uid else {
                print("No user is currently signed in")
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users").document(uid).updateData(["profileImageUrl": imageUrl]) { [weak self] error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                    return
                }
                
                print("Profile image url successfully updated in Firestore")
                self?.user?.profileImageUrl = imageUrl
                
                //Save the updated User instance in Persistence Manager
                PersistenceManager.saveUserProfile(user: self?.user ?? User(uid: "", name: "", profileImageUrl: "", bookmarkedRecipes: [])) { error in
                    if let error = error {
                        print("Error saving user profile: \(error.localizedDescription)")
                    }
                }
            }
        }
    
    
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
                self.nameLabel.text = "Name: \(name)"
                
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
