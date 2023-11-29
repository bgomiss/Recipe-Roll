//
//  ProfileVCPresenter.swift
//  practice
//
//  Created by aycan duskun on 29.11.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI


class ProfileVCPresenter: PHPickerViewControllerDelegate {
    
    
    private weak var profileVC: ProfileVC?
    
    init(profileVC: ProfileVC?) {
        self.profileVC = profileVC
    }
    
    func logoutCompleted() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("User signed Out successfully")
            
            // Get a reference to the SceneDelegate from the current context
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            
            // Call the function to reset the window's rootViewController
            sceneDelegate.showMainApp()
            
            } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func imagePickerPresented() {
        // Use PHPickerViewController
               var configuration = PHPickerConfiguration()
               configuration.selectionLimit = 1
               configuration.filter = .images
               let picker = PHPickerViewController(configuration: configuration)
               picker.delegate = self
               profileVC?.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        profileVC?.dismiss(animated: true, completion: nil)

        guard let itemProvider = results.first?.itemProvider,
                  itemProvider.canLoadObject(ofClass: UIImage.self) else { return }

        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            DispatchQueue.main.async {
                guard let self = self,
                      let image = image as? UIImage else { return }

                self.profileVC?.profileImageView.image = image
                self.profileVC?.updateProfileImageClosure?(image)
                guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
                        self.uploadProfileImageToFirebaseStorage(imageData)
                    }
                }
    }
    
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
            self?.profileVC?.user?.profileImageUrl = imageUrl
            
            //Save the updated User instance in Persistence Manager
            PersistenceManager.saveUserProfile(user: self?.profileVC?.user ?? User(uid: "", name: "", profileImageUrl: "", bookmarkedRecipes: [])) { error in
                if let error = error {
                    print("Error saving user profile: \(error.localizedDescription)")
                }
            }
        }
    }
}
