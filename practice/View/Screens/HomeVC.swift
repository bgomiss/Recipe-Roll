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


class HomeVC: UIViewController, UISheetPresentationControllerDelegate {
    
    var user: User?
    let titleLabel                      = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let userImage                       = SPImageView(cornerRadius: 40)
    let querySearchBar                  = SPSearchBar()
    var queryRecipesVC: QueryRecipesVC!
    let cancelButton                    = SPButton(backgroundColor: .clear, title: "Cancel")
    var recipes: [(tag: String, recipe: [Recipe])]      = []
    var similarRecipesArray: [GetSimilarRecipes] = []
    var ingredientsResultss: [Ingredients] = []
    var recommendedRecipeInstructions: Instructions?
    let categoryHeaderView              = CategoriesHeaderView()
    let recommendationHeaderTitle       = SPTitleLabel(text: "Recommendation", textAlignment: .left, fontSize: 20)
    var ingredientsResults: [Ent] = []
    let recommendationSeeAllButton      = SPButton(backgroundColor: .clear, title: "See All")
    let tags = [Tags.breakfast, Tags.lunch, Tags.dinner, Tags.soup, Tags.dessert]
    var recipeResultsVC = RecipeResultsVC()
    var vc = UIViewController()
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
    
    var recipeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCompositionalLayout()
//        setupQueryRecipesVC()
        layoutUI()
        configure()
        getCategories()
        createDismissKeyboardTapGesture()
        retrieveUserInfo()
        //fetchSimilarRecipes(recipeID: recipeId ?? "651942")
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
//                PersistenceManager.retrieveUserProfile { [weak self] result in
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vc.dismiss(animated: true)
    }
    
    
    deinit {
        searchDebounceTimer?.invalidate()
        searchDebounceTimer = nil
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
    
    
    func makeAPICallForCategories(tag: String, completion: @escaping ([Recipe]) -> Void) {
        NetworkManager.shared.getRecipesInfo(for: .searchCategory(tag)) { category in
            switch category {
            case .success(let categories):
                completion(categories)
            case .failure(_): completion([])
                
            }
        }
    }
    
    func updateUI(with categories: [Recipe], atIndex index: Int) {
        self.recipes[index].recipe = categories
    }
    
    
    func getCategories() {
        // First, try to retrieve categories from cache
        let group = DispatchGroup()
        recipes = tags.map { (tag: $0, recipe: [])}
        
        for (index, tag) in tags.enumerated() {
            group.enter()
            
            self.makeAPICallForCategories(tag: tag) { categories in
                self.updateUI(with: categories, atIndex: index)
                group.leave()
            }
        }
            
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
        
    }
    
    
    
    func fetchSimilarRecipes(recipeID: String) {
        print("Fetching similar recipes for recipeID: \(recipeID)")
        NetworkManager.shared.getSimilarRecipes(recipeID: recipeID) { [weak self] result in
            
            guard let self else { return }
            
            switch result {
            case .success(let similarRecipes):
                print("Fetched similar recipes")
                self.similarRecipesArray.append(contentsOf: similarRecipes)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching similar recipes: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    func extractIngredients(from analyzedInstructions: [AnalyzedInstructions]) {
        for instruction in analyzedInstructions {
            for step in instruction.steps {
                let steps = SimplifiedStep(number: step.number, step: step.step)
                recipeResultsVC.stepsResults.append(steps)
                
                for ingredient in step.ingredients {
                    let imageURL = "https://spoonacular.com/cdn/ingredients_100x100/\(ingredient.image)"
                    let newIngredient = Ingredients(id: ingredient.id, name: ingredient.name, localizedName: ingredient.localizedName, image: imageURL)
                    ingredientsResultss.append(newIngredient)
                }
            }
        }
    }
    
    
    func fetchRecommendedRecipeInstructions(recipeID: String) {
        print("Fetching recipe instructions for recipeID: \(recipeID)")
        NetworkManager.shared.getRecommendedRecipeInstructions(recipeID: recipeID) { [weak self] result in
    
            guard let self else { return }
            
            switch result {
            case .success(let instructions):
                //print("Fetched Instructions are : \(instructions)")
                
                DispatchQueue.main.async {
                    self.recommendedRecipeInstructions = instructions
                    self.extractIngredients(from: instructions.analyzedInstructions)
                    print("RECOMMENDED INSTRUCTIONS ARE : \(self.recommendedRecipeInstructions!)")
                    self.collectionView.reloadData()
                }
                
                
             case .failure(let error):
                print("Error fetching instructions: \(error.localizedDescription)")
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
            
//            queryRecipesVC.view.topAnchor.constraint(equalTo: querySearchBar.bottomAnchor),
//            queryRecipesVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            queryRecipesVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            queryRecipesVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

