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

class ProfileVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var profileImageView = SPImageView(cornerRadius: 50)
    var nameLabel = SPTitleLabel(textAlignment: .center, fontSize: 24)
    var emailLabel = SPSecondaryTitleLabel(fontSize: 18, color: .black)
    var uploadImageButton = SPButton(backgroundColor: .systemBlue, title: "Upload Image")
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        setupConstraints()
        fetchProfileData()
        
        uploadImageButton.addTarget(self, action: #selector(uploadImageButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func uploadImageButtonTapped() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    
    
    func uploadProfileImageToFirebaseStorage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        
        let storageRef = Storage.storage().reference()
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("No current user ID")
            return
        }
        let profileImagesRef = storageRef.child("profile_images/\(currentUserID).jpg")
        
        let uploadTask = profileImagesRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            profileImagesRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let url = url else {
                    print("Could not get download URL")
                    return
                }
                
                completion(.success(url.absoluteString))
            }
        }
        uploadTask.resume()
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
            
            let data = document.data()
            self.nameLabel.text = "Name: \(data?["name"] as? String ?? "")"
            self.emailLabel.text = "Email: \(data?["email"] as? String ?? "")"
            
            if let profileImageUrl = data?["profileImageUrl"] as? String {
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
