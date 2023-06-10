//
//  ViewController.swift
//  practice
//
//  Created by aycan duskun on 12.03.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class HomeVC: UIViewController {
    var user: User?
    let titleLabel                      = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let userImage                       = SPImageView(cornerRadius: 40)
    let queryTextField                  = SPTextField(placeholder: "Search for a Delicious Food")
    var recipes: [(tag: String, recipe: [Recipe])]      = []
    let categoryHeaderView              = CategoriesHeaderView()
    let recommendationHeaderTitle       = SPTitleLabel(text: "Recommendation", textAlignment: .left, fontSize: 20)
    
    let recommendationSeeAllButton      = SPButton(backgroundColor: .clear, title: "See All")
    let tags = [Tags.breakfast, Tags.lunch, Tags.dinner, Tags.soup, Tags.dessert]
    let group = DispatchGroup()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseID)
        collectionView.register(RecommendationCollectionViewCell.self, forCellWithReuseIdentifier: RecommendationCollectionViewCell.reuseID)
        collectionView.register(CategoriesHeaderView.self, forSupplementaryViewOfKind: "CategoriesHeader", withReuseIdentifier: CategoriesHeaderView.headerIdentifier)
        collectionView.register(RecommendationHeaderView.self, forSupplementaryViewOfKind: "RecommendationHeader", withReuseIdentifier: RecommendationHeaderView.headerIdentifier)
        collectionView.backgroundColor = .systemBackground
       
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCompositionalLayout()
        layoutUI()
        fetchRecipeData()
        configureUIElements()
        configure()
        createDismissKeyboardTapGesture()
        retrieveUserInfo()
//        PersistenceManager.retrieveUserProfile { [weak self] result in
//                switch result {
//                case .success(let user):
//                    if let profileImageUrl = user?.profileImageUrl {
//                        self?.userImage.downloadImage(fromURL: profileImageUrl)
//                    }
//
//                case .failure(let error):
//                    print("Error retrieving user profile: \(error.localizedDescription)")
//                }
//            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func retrieveUserInfo() {
        if let uid = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            db.collection("users").document(uid).getDocument { [weak self] document, error in
                if let error = error {
                    print("Error fetching user data: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists, let data = document.data() else {
                    print("No document found for this user")
                    return
                }
                
                // Create a User instance with the retrieved data
                let user = User(uid: uid, name: data["name"] as? String ?? "", profileImageUrl: data["profileImageUrl"] as? String ?? "", bookmarkedRecipes: [])
                
                // Assign the user instance to the property in HomeVC
                self?.user = user
                
                // Update the UI with the user's profile image
                self?.userImage.downloadImage(fromURL: user.profileImageUrl!)
                self?.titleLabel.text = "What would you like to cook today, \(user.name)?"
            }
        }
    }
    
    
    func getCategories(tag: String, atIndex index: Int, group: DispatchGroup) {
        NetworkManager.shared.getRecipesInfo(for: .searchCategory(tag)) { [weak self] category in
            
            guard let self = self else { return }
            
            switch category {
            case .success(let categories):
                self.updateUI(with: categories, atIndex: index)
            case .failure(let error):
                break
            }
            group.leave()
        }
    }
    
    func fetchRecipeData() {
        recipes = tags.map { (tag: $0, recipe: []) }
        
        for (index, tag) in tags.enumerated() {
            group.enter()
            getCategories(tag: tag, atIndex: index, group: group)
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
//    func getCategories() {
//        PersistenceManager.retrievedCategories { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let categories):
//                self.updateUI(with: categories)
//
//            case .failure(let error):
//                return
//            }
//        }
//    }
    
    func configure() {
        collectionView.setUp(to: view, and: queryTextField)
    }
    
    
    func updateUI(with categories: [Recipe], atIndex index: Int) {

        DispatchQueue.main.async {
            self.recipes[index].recipe = categories
        }
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    func configureUIElements() {
        let searchIcon = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: searchIcon)
        imageView.contentMode = .scaleAspectFit
        queryTextField.leftViewMode = .always
        queryTextField.leftView = imageView
    }
    
    
    func layoutUI() {
        view.addSubviews(queryTextField, titleLabel, userImage, collectionView)
        queryTextField.delegate = self
        
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            queryTextField.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            userImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userImage.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 60),
            userImage.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}


extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        queryTextField.resignFirstResponder()
    }
}

extension HomeVC {
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return UIHelper.categoriesSection()
                
            case 1 :
                return UIHelper.recommendationSection()
                
            default:
                return UIHelper.categoriesSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

