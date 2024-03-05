//
//  RecipesVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

enum DisplayableItem: Hashable {
    case ingredient(Ingredient)
    case recipe(FindByIngredients)
}

class FridgeVC: UIViewController, UISearchBarDelegate {
    
    enum Section { case main }
    enum CurrentState { case recipe, ingredient }
        
    
    var currentState: CurrentState = .ingredient
    let ingredientsVC = IngredientsVC()
    var user: User?
    var homeVC = HomeVC()
    private var ingredients = [String]()
    var ingredientsArray: [DisplayableItem] = []
    var recipesArray: [DisplayableItem] = []
    var selectedIngredients: [DisplayableItem] = []
    var hasMoreIngredients = true
    var page = 1
    var isLoadingMoreIngredients = false
    var dataSource: UICollectionViewDiffableDataSource<Section, DisplayableItem>!
    
    private let ingredientSearchBar: SPSearchBar = {
        let searchBar = SPSearchBar(placeholder: "Enter an ingredient")
        return searchBar
    }()
    
    
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.register(FridgeVcCell.self, forCellWithReuseIdentifier: FridgeVcCell.reuseID)
        return cv
    }()
    
    
    private lazy var userImageView: SPImageView = {
        let imageView = SPImageView(cornerRadius: 20)
        imageView.downloadImage(fromURL: self.user?.profileImageUrl ?? "https://cdn.dribbble.com/userupload/4968424/file/original-d073fb8764a78a20bafb71c762702fea.png?compress=1&resize=1600x1200" )
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's in your fridge?"
        label.textAlignment = .center
        return label
    }()
    
    private let selectedIngredientsLabel: UILabel = {
        let label = SPTitleLabel(text: "Selected Ingredients", textAlignment: .left, fontSize: 15)
        label.textColor = .white
        return label
    }()
    
    private let resetButton: UIButton = {
        let button = SPButton()
        button.set(withColor: .white, backgroundColor: .systemGray, title: "Reset")
        button.addTarget(IngredientsVC().self, action: #selector(handleResetButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let findRecipesButton: UIButton = {
        let button = SPButton()
        button.set(withColor: .systemMint, backgroundColor: .white, title: "Find Recipes")
        button.addTarget(IngredientsVC().self, action: #selector(handleFindRecipesButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        ingredientsVC.fridgeVC = self
        configureDataSource()
        setupUserImageView()
        setupTitleLabel()
        setupSelectedIngredientsLabel()
        setupFindRecipesButton()
        setupActivityIndicator()
        setupResetButton()
        setupSearchBar()
        configureCollectionView()
        configure()
        
    }
    
    
    func getIngredients(ingredient: String) {
        isLoadingMoreIngredients = true
        activityIndicator.startAnimating()
        collectionView.isHidden = true
        
        NetworkManager.shared.getRecipesInfo(for: .ingredientsAutoSearch(ingredient), completed: { _ in }) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let ingredients):
                    DispatchQueue.main.async {
                        self.ingredientsArray = ingredients.map {DisplayableItem.ingredient($0)}
                        self.updateIngredientsData(on: self.ingredientsArray) // Call updateData instead of reloading the collectionView
                        self.activityIndicator.stopAnimating()
                        self.collectionView.isHidden = false
                    }
                
            case .failure(let error):
                print(error.localizedDescription)
                //self.view.bringSubviewToFront(self.tableView)
            }
            self.isLoadingMoreIngredients = false
        }
    }
    
    
    func getRecipes(recipe: String) {
        activityIndicator.startAnimating()
        collectionView.isHidden = true
        
        NetworkManager.shared.getRecipesInfo(for: .myRefrigerator(recipe), completed: { _ in }, findByIngCompleted:  { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self.recipesArray = recipes.map {DisplayableItem.recipe($0)}
                    print("recipesArray IS: \(self.recipesArray)")
                    self.updateRecipesData(on: self.recipesArray) // Call updateData instead of reloading the collectionView
                    self.updateLayout(for: .recipe)
                    self.activityIndicator.stopAnimating()
                    self.collectionView.isHidden = false
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                //self.view.bringSubviewToFront(self.tableView)
            }
         })
    }
    
    
    func getSelectedIngredientsCount() -> Int {
            return selectedIngredients.count
        }
    
    
   
       func configureDataSource() {
           dataSource = UICollectionViewDiffableDataSource<Section, DisplayableItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
               
               switch item {
               case .ingredient(let ingredient):
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FridgeVcCell.reuseID, for: indexPath) as! FridgeVcCell
                   cell.setFor(ingredients: ingredient)
                   return cell
               case .recipe(let recipe):
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FridgeVcCell.reuseID, for: indexPath) as! FridgeVcCell
                   cell.setFor(recipes: recipe)
                   return cell
               }
                       
            })
              collectionView.dataSource = dataSource
       }
    
    
    func updateIngredientsData(on ingredients: [DisplayableItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DisplayableItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(ingredients, toSection: .main)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    
    func updateRecipesData(on recipes: [DisplayableItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DisplayableItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(recipes, toSection: .main)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    private func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    
    func configure() {
        self.view.addSubview(ingredientsVC.view) // Add the child's view to the parent's view
        self.addChild(ingredientsVC) // Add the child view controller to the parent
        ingredientsVC.didMove(toParent: self) // Notify the child view controller
        
        NSLayoutConstraint.activate([
            ingredientsVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            ingredientsVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -30),
            ingredientsVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:  -100),
            ingredientsVC.view.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    private func setupUserImageView() {
        self.view.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitleLabel() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setupSearchBar() {
        self.view.addSubview(ingredientSearchBar)
        
        NSLayoutConstraint.activate([
            ingredientSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            ingredientSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            ingredientSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        ingredientSearchBar.delegate = self
    }
    
    private func setupResetButton() {
        ingredientsVC.view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: ingredientsVC.view.topAnchor, constant: 10),
            resetButton.trailingAnchor.constraint(equalTo: ingredientsVC.view.trailingAnchor, constant: -10),
            resetButton.heightAnchor.constraint(equalToConstant: 20),
            resetButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupSelectedIngredientsLabel() {
        ingredientsVC.view.addSubviews(selectedIngredientsLabel, ingredientsVC.stackView)
        ingredientsVC.stackView.backgroundColor = .cyan
        NSLayoutConstraint.activate([
            selectedIngredientsLabel.topAnchor.constraint(equalTo: ingredientsVC.view.topAnchor, constant: 10),
            selectedIngredientsLabel.leadingAnchor.constraint(equalTo: ingredientsVC.view.leadingAnchor, constant: 10),
            selectedIngredientsLabel.heightAnchor.constraint(equalToConstant: 20),
            selectedIngredientsLabel.widthAnchor.constraint(equalToConstant: 160),
            
            ingredientsVC.stackView.leadingAnchor.constraint(equalTo: selectedIngredientsLabel.trailingAnchor),
            ingredientsVC.stackView.trailingAnchor.constraint(equalTo: ingredientsVC.view.trailingAnchor, constant: -70),
            ingredientsVC.stackView.topAnchor.constraint(equalTo: ingredientsVC.view.topAnchor, constant: 10),
            ingredientsVC.stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupFindRecipesButton() {
        ingredientsVC.view.addSubview(findRecipesButton)
        
        NSLayoutConstraint.activate([
            findRecipesButton.bottomAnchor.constraint(equalTo: ingredientsVC.view.bottomAnchor, constant: -20),
            findRecipesButton.trailingAnchor.constraint(equalTo: ingredientsVC.view.trailingAnchor, constant: -60),
            findRecipesButton.leadingAnchor.constraint(equalTo: ingredientsVC.view.leadingAnchor, constant: 60),
            findRecipesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let ingredient = searchBar.text, !ingredient.isEmpty else { return }
        ingredientsArray.removeAll()
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        getIngredients(ingredient: ingredient)
        // Directly set layout for ingredients
        currentState = .ingredient
        updateLayout(for: currentState)
    }
    
    
    @objc func handleResetButtonTap() {
        selectedIngredients.removeAll()
        
        // remove all arranged subviews from the stackview
        for arrangedSubview in ingredientsVC.stackView.arrangedSubviews {
            ingredientsVC.stackView.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
        
        // clear the StackView's layout constraints
        ingredientsVC.stackView.subviews.forEach{ $0.removeFromSuperview() }
    }
    
    
    func updateLayout(for state: CurrentState) {
        switch state {
        case .ingredient:
            print("Setting three column layout.")
            let newLayout = UIHelper.createThreeColumnFlowLayout(in: view)
            collectionView.setCollectionViewLayout(newLayout, animated: true)
        case .recipe:
            print("Setting two column layout.")
            let newLayout = UIHelper.createTwoColumnFlowLayout(in: view)
            collectionView.setCollectionViewLayout(newLayout, animated: true)
        }
    }
    
    
    @objc func handleFindRecipesButtonTap() {
        // Fetch recipes with ingredients and present new view controller
        print("Find recipes tapped.")
        let ingredientNames = selectedIngredients.compactMap { item -> String? in
            if case let .ingredient(ingredient) = item {
                return ingredient.name
            }
            return nil
        }
        let ingredientsString = ingredientNames.joined(separator: ",")
        print("IngredientsARE: \(ingredientsString)")
        //if !ingredients.isEmpty {
            recipesArray.removeAll()
            getRecipes(recipe: ingredientsString)
        currentState = .recipe
        updateLayout(for: currentState)
            //}
    }
}
    
extension FridgeVC: UICollectionViewDelegate {
        
        func configureCollectionView() {
            view.addSubview(collectionView)
            collectionView.delegate = self
            //collectionView.dataSource = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            //collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ingredientsVC.view.frame.height, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: ingredientSearchBar.bottomAnchor, constant: 20),
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
        }
        
        
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return ingredientsArray.count
//        }
        
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FridgeVcCell.reuseID, for: indexPath) as? FridgeVcCell else {fatalError("unable to dequeue")}
//
//            let ingredient = ingredientsArray[indexPath.item]
//            cell.set(ingredients: ingredient)
//            print("Setting cell with ingredient: \(ingredient)")
//            return cell
//        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            guard let selectedIngredient = dataSource.itemIdentifier(for: indexPath), !selectedIngredients.contains(selectedIngredient) else { return }
            
            switch selectedIngredient {
            case .ingredient(let ingredient):
                selectedIngredients.append(selectedIngredient)
                var currentSnapshot = dataSource.snapshot()
                currentSnapshot.appendItems([selectedIngredient])
                DispatchQueue.main.async {
                self.dataSource.apply(currentSnapshot, animatingDifferences: true)
                self.ingredientsVC.addIngredient(ingredient)
                print(self.selectedIngredients)
            }
            case .recipe(let selectedIngredient):
                homeVC.fetchRecommendedRecipeInstructions(recipeID: String(selectedIngredient.id), shouldReloadCollectionView: false)
                homeVC.performIngredientsFiltering(presentingViewController: self)
                self.collectionView.reloadData()
            }
        
        }
    }


