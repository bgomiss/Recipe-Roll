//
//  ShopListVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit
import Firebase

class BookmarksVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    let uid                          = Auth.auth().currentUser?.uid
    let db                           = Firestore.firestore()
    let querySearchBar               = SPSearchBar()
    var bookmarkedRecipes: [(String, [Recipe])] = []
    var fetchSimilarRecipesClosure: ((Int64) -> Void)?
    var categoryID: String = ""
    weak var delegate: SeeAllDelegate?
    var bookmarksPresenter: BookmarksPresenter?
    var recipesForSection: [Recipe] = []
    let backButton = UIButton(type: .system)

    
    let categoryMapping: [Int: String] = [
        0: "Recently Viewed",
        1: "MadeIt",
        2: "Breakfast",
        3: "Lunch",
        4: "Dinner"
        ]
    
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
    
    
    lazy var tableView: UITableView = {
            let tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.dataSource = self
            tableView.delegate = self
            self.navigationItem.title = "ALL RECIPES"
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.frame = view.bounds
            tableView.rowHeight = 100
            tableView.register(RecipesCell.self, forCellReuseIdentifier: RecipesCell.reuseID)
        
        // Add backButton to the tableView's superview
            if let superview = tableView.superview {
                superview.addSubview(backButton)
                backButton.translatesAutoresizingMaskIntoConstraints = false
                backButton.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16).isActive = true
                backButton.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
                backButton.setTitle("Back", for: .normal)
                backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            }
            return tableView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(querySearchBar, collectionView)
        configureCompositionalLayout()
        createDismissKeyboardTapGesture()
        layoutUI()
        configure()
        configureUIElements()
        view.backgroundColor = .systemBackground
        bookmarksPresenter = BookmarksPresenter(bookmarksVC: self)
        fetchBookmarkedRecipeIDs()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func seeAllButtonTapped (sender: UIButton) {
        delegate?.didTapSeeAllButton(sender: sender)
    }
    
    @objc func backButtonTapped() {
        delegate?.didTapbackButton()
        }
    
    func fetchBookmarkedRecipeIDs() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userBookmarkCollection = db.collection("bookmarks").document(userID).collection("categories")
        
        userBookmarkCollection.getDocuments { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            guard let categories = querySnapshot?.documents else { return }
            
            for category in categories {
                categoryID = category.documentID
                print("CATEGORY ID IS: \(String(describing: categoryID))")

                let recipeData = category.data()
                for (_, recipeDetail) in recipeData {
                    if let detailDict = recipeDetail as? [String: Any],
                       let recipeID = detailDict["id"] as? Int64 {
                        self.getCategoriess(query: String(recipeID), categoryID: categoryID)
                    }
                }
                    
                    if categoryID == "Recently Viewed" {
                        if let firstRecipe = categories.first,
                           let recipeData = firstRecipe.data() as? [String: Any],
                           let nestedDict  = recipeData.values.first as? [String: Any],
                           let recipeID = nestedDict["id"] as? Int {
                            print("TarifID is: \(recipeID)")
                            
                            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                               let existingTabBarController = sceneDelegate.window?.rootViewController as? SPTabBarController,
                               let homeNavVC = existingTabBarController.viewControllers?[0] as? UINavigationController,
                               let homeVC = homeNavVC.viewControllers.first as? HomeVC {
                                if (recipeID != 0) {
                                    homeVC.fetchSimilarRecipes(recipeID: String(recipeID))
                                    
                                } else {
                                    homeVC.fetchSimilarRecipes(recipeID: "651942")
                                }
                                
                            }
                        }
                    }
                print("Number of documents in category \(categoryID): \(recipeData.count)")
                }
                
            }
        }
    
    
        func createDismissKeyboardTapGesture() {
            let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(tap)
        }
        
        
        func configure() {
            collectionView.setUp(to: view, and: querySearchBar)
        }
        
        
        func configureUIElements() {
            let searchIcon = UIImage(systemName: "magnifyingglass")
            let imageView = UIImageView(image: searchIcon)
            imageView.contentMode = .scaleAspectFit
            
        }
            //        queryTextField.leftViewMode = .always
            //        queryTextField.leftView = imageView
        
        
    func getCategoriess(query: String, categoryID: String) {
        
        Task {
            do {
                
                let newRecipe = try await NetworkManager.shared.getRecipessInfo(for: .bookmarks(query)) as Recipe
                
                // Check if the categoryID exists in the array
                if let index = self.bookmarkedRecipes.firstIndex(where: { $0.0 == categoryID }) { 
                    // If exists, append to existing recipes
                    // If exists, check if the recipe is not already in the array
                    if !self.bookmarkedRecipes[index].1.contains(where: { $0.id == newRecipe.id }) {
                        self.bookmarkedRecipes[index].1.append(newRecipe)
                    }
                } else {
                    // If not, add a new tuple
                    bookmarkedRecipes.append((categoryID, [newRecipe]))

                }
                DispatchQueue.main.async {
                    if let index = self.bookmarkedRecipes.firstIndex(where: { $0.0 == categoryID }) { //&& $0.1.contains(where: { $0.id == newRecipe.id })
                        
                        print("Count of Recipe in \(categoryID) is \(self.bookmarkedRecipes[index].1.count)")
                    }
                    self.collectionView.reloadData()
                }
            } catch SPError.unableToComplete {
                
            }
        }
    }
        
        
        func layoutUI() {
            querySearchBar.delegate = self
            
            NSLayoutConstraint.activate([
                querySearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                querySearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                querySearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                querySearchBar.heightAnchor.constraint(equalToConstant: 40),
            ])
        }
}
    
    extension BookmarksVC: UISearchBarDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            querySearchBar.resignFirstResponder()
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

