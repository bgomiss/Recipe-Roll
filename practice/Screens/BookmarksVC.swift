//
//  ShopListVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit
import Firebase

class BookmarksVC: UIViewController {
    
    
    let uid = Auth.auth().currentUser?.uid
    let db  = Firestore.firestore()
    let queryTextField                  = SPTextField(placeholder: "Search Saved recipes")
    var recipes: [Recipe]              = []
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        //CollectionViewCells
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RVCollectionViewCell.self, forCellWithReuseIdentifier: RVCollectionViewCell.reuseID)
        collectionView.register(MadeItCollectionViewCell.self, forCellWithReuseIdentifier: MadeItCollectionViewCell.reuseID)
        collectionView.register(BreakfastCollectionViewCell.self, forCellWithReuseIdentifier: BreakfastCollectionViewCell.reuseID)
        collectionView.register(LunchCollectionViewCell.self, forCellWithReuseIdentifier: LunchCollectionViewCell.reuseID)
        collectionView.register(DinnerCollectionViewCell.self, forCellWithReuseIdentifier: DinnerCollectionViewCell.reuseID)
        
        //HeaderViews
        collectionView.register(RVHeaderView.self, forSupplementaryViewOfKind: "RVHeader", withReuseIdentifier: RVHeaderView.headerIdentifier)
        collectionView.register(MadeItHeaderView.self, forSupplementaryViewOfKind: "MadeItHeader", withReuseIdentifier: MadeItHeaderView.headerIdentifier)
        collectionView.register(BreakfastHeaderView.self, forSupplementaryViewOfKind: "BreakfastHeader", withReuseIdentifier: BreakfastHeaderView.headerIdentifier)
        collectionView.register(LunchHeaderView.self, forSupplementaryViewOfKind: "LunchHeader", withReuseIdentifier: LunchHeaderView.headerIdentifier)
        collectionView.register(DinnerHeaderView.self, forSupplementaryViewOfKind: "DinnerHeader", withReuseIdentifier: DinnerHeaderView.headerIdentifier)
        collectionView.backgroundColor = .systemBackground
       
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(queryTextField, collectionView)
        configureCompositionalLayout()
        fetchBookmarkedRecipeIDs()
        createDismissKeyboardTapGesture()
        layoutUI()
        configure()
        configureUIElements()
        view.backgroundColor = .systemBackground
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
   
    func fetchBookmarkedRecipeIDs() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userBookmarkCollection = db.collection("bookmarks").document(userID).collection("categories")
        userBookmarkCollection.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            guard let categories = querySnapshot?.documents else { return }
            
            for category in categories {
                let categoryID = category.documentID
                let recipesCollection = userBookmarkCollection.document(categoryID).collection(categoryID)
                
                recipesCollection.getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error fetching recipes: \(error)")
                        return
                    }
                }
            }
            guard let recipes = querySnapshot?.documents else { return }
            
            for recipe in recipes {
                let recipeData = recipe.data()
                print("recipe data: \(recipeData)")
                for (_, recipeDetail) in recipeData {
                    if let detailDict = recipeDetail as? [String: Any], let recipeID = detailDict["id"] as? Int64 {
                        print("recipeID is: \(recipeID)")
                        self.getCategories(query: String(recipeID))
                    }
                        
                    }
                }
            }
        }
    

    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configure() {
        collectionView.setUp(to: view, and: queryTextField)
    }
    
    
    func configureUIElements() {
        let searchIcon = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: searchIcon)
        imageView.contentMode = .scaleAspectFit
        queryTextField.leftViewMode = .always
        queryTextField.leftView = imageView
    }
    
    
    func getCategories(query: String) {
        NetworkManager.shared.getRecipesInfo(for: .bookmarks(query)) { [weak self] category in
            
            guard let self = self else { return }
            
            switch category {
            case .success(let categories):
                self.updateUI(with: categories)
            case .failure(let error):
                return
            }
        }
    }
    
    
    func updateUI(with categories: [Recipe]) {
        recipes.append(contentsOf: categories)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            //self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    
    func layoutUI() {
        queryTextField.delegate = self
    
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            queryTextField.heightAnchor.constraint(equalToConstant: 40),
       ])
    }
}

extension BookmarksVC: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            queryTextField.resignFirstResponder()
        }
    }

extension BookmarksVC {
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return UIHelper.rvSection()
                
            case 1 :
                return UIHelper.madeItSection()
                
            case 2 :
                return UIHelper.breakfastSection()
                
            case 3 :
                return UIHelper.lunchSection()
                
            case 4 :
                return UIHelper.dinnerSection()
                
            default:
                return UIHelper.categoriesSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
