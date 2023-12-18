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
    let querySearchBar                  = SPSearchBar()
    var queryRecipesVC: QueryRecipesVC!
    let cancelButton                    = SPButton(backgroundColor: .clear, title: "Cancel")
    var recipes: [(tag: String, recipe: [Recipe])]      = []
    var similarRecipesArray: [GetSimilarRecipes] = []
    let categoryHeaderView              = CategoriesHeaderView()
    let recommendationHeaderTitle       = SPTitleLabel(text: "Recommendation", textAlignment: .left, fontSize: 20)
    
    let recommendationSeeAllButton      = SPButton(backgroundColor: .clear, title: "See All")
    let tags = [Tags.breakfast, Tags.lunch, Tags.dinner, Tags.soup, Tags.dessert]
    let group = DispatchGroup()
    
    private var searchDebounceTimer: Timer?
    
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
        setupQueryRecipesVC()
        layoutUI()
        configure()
        getCategoriesFromCache()
        createDismissKeyboardTapGesture()
        retrieveUserInfo()
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
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
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func setupQueryRecipesVC() {
        queryRecipesVC = QueryRecipesVC()
        addChild(queryRecipesVC)
        view.addSubview(queryRecipesVC.view)
        queryRecipesVC.didMove(toParent: self)
        queryRecipesVC.view.isHidden = true
        queryRecipesVC.view.translatesAutoresizingMaskIntoConstraints = false
        querySearchBar.delegate = self
    }
    
    
    @objc func cancelButtonTapped() {
        queryRecipesVC.view.isHidden = true
        collectionView.isHidden = false
        cancelButton.isHidden = true
        querySearchBar.text = ""
    }

    
    func retrieveUserInfo() {
        PersistenceManager.retrieveUserProfile { [weak self] result in
                        switch result {
                        case .success(let user):
                            guard let user = user,
                                  let profileImageUrl = user.profileImageUrl,
                                  let name = user.name
                            else {return}
                            print("USER IS: \(user)")
                            
                                DispatchQueue.main.async {
                                    self?.userImage.downloadImage(fromURL: profileImageUrl)
                                    self?.titleLabel.text = "What would you like to cook today, \(name)?"
                                    print("PROFILE IMAGE URL IS: \(profileImageUrl)")
                                }
                                
                        case .failure(let error):
                            print("Error retrieving user profile: \(error.localizedDescription)")
                        }
                    }
                }
    
    
    func makeAPICallForCategories(tag: String, atIndex index: Int, group: DispatchGroup) {
        NetworkManager.shared.getRecipesInfo(for: .searchCategory(tag)) { [weak self] category in
            
            guard let self = self else { return }
           
            
            switch category {
            case .success(let categories):
                
                for category in categories {
                    PersistenceManager.updateWith(category: category, actionType: .add) { error in
                        if let error = error {
                            print("Error saving category: \(error)")
                        }
                    }
                }
            self.updateUI(with: categories, atIndex: index)
            case .failure(_): break
                
            }
            group.leave()
        }
    }
    
    func updateUI(with categories: [Recipe], atIndex index: Int) {
           
           DispatchQueue.main.async {
               self.recipes[index].recipe = categories
           }
       }
    
    
    func getCategoriesFromCache() {
        // First, try to retrieve categories from cache
        recipes = tags.map { (tag: $0, recipe: [])}
        for (index, tag) in tags.enumerated() {
            group.enter()
            
            PersistenceManager.retrievedCategories { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let cachedCategories):
                    if !cachedCategories.isEmpty {
                        // If cached categories are available, update UI
                        print("Data is coming from cache: \(cachedCategories)")
                        self.updateUI(with: cachedCategories, atIndex: index)
                    } else {
                        // If not available in cache, make API call
                        print("Data is not available in cache, making API call...")
                        self.makeAPICallForCategories(tag: tag, atIndex: index, group: group)
                    }
                    // If there's an error retrieving from cache, make API call
                case .failure(let error):
                    print("Error retrieving categories from cache: \(error)")
                    
                    }
                
                }
            self.group.notify(queue: .main) {
            self.collectionView.reloadData()
            }
            
        }
    }
    
    
    
    func fetchSimilarRecipes(recipeID: String, completion: @escaping (Result<[GetSimilarRecipes], SPError>) -> Void) {
        print("Fetching similar recipes for recipeID: \(recipeID)")
        NetworkManager.shared.getSimilarRecipes(recipeID: recipeID) { result in
            
            //guard let self = self else {return}
            
            switch result {
            case .success(let similarRecipes):
                print("Fetched similar recipes")
                DispatchQueue.main.async {
                    print("Reloading collection view...")
                    completion(.success(similarRecipes))
                    self.similarRecipesArray.append(contentsOf: similarRecipes)
                    self.collectionView.reloadData()
                    print("Collection view reloaded.")
                }
                
            case .failure(let error):
                print("Error fetching similar recipes: \(error.localizedDescription)")
                DispatchQueue.main.async {
                completion(.failure(error))
                }
                //self.view.bringSubviewToFront(self.tableView)
              }
            }
        }
    
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    func configure() {
            collectionView.setUp(to: view, and: querySearchBar)
            cancelButton.isHidden = true
        }
    
    
    func layoutUI() {
        view.addSubviews(querySearchBar, titleLabel, userImage, collectionView, cancelButton)
        
        NSLayoutConstraint.activate([
            querySearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            querySearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            querySearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            querySearchBar.heightAnchor.constraint(equalToConstant: 40),
            
            cancelButton.leadingAnchor.constraint(equalTo: querySearchBar.trailingAnchor, constant: 5),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            cancelButton.centerYAnchor.constraint(equalTo: querySearchBar.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            userImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userImage.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 60),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            
            queryRecipesVC.view.topAnchor.constraint(equalTo: querySearchBar.bottomAnchor),
            queryRecipesVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            queryRecipesVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            queryRecipesVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension HomeVC: UISearchBarDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        querySearchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //queryRecipesVC.reloadTableView()
        queryRecipesVC.view.isHidden = false
        collectionView.isHidden      = true
        cancelButton.isHidden        = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Invalidate the previous debounce timer
        searchDebounceTimer?.invalidate()
        
        // Start a new debounce timer
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.queryRecipesVC.searchText = searchText
            self?.queryRecipesVC.updateUI()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
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

