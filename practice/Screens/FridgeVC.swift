//
//  RecipesVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class FridgeVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let ingredientsVC = IngredientsVC()
    var user: User?
    private var ingredients = [String]()
    private let tableView = UITableView()
    
    private let ingredientSearchBar: SPSearchBar = {
        let searchBar = SPSearchBar(placeholder: "Enter an ingredient")
        return searchBar
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
        button.addTarget(self, action: #selector(handleResetButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let findRecipesButton: UIButton = {
        let button = SPButton()
        button.set(withColor: .systemMint, backgroundColor: .white, title: "Find Recipes")
        button.addTarget(self, action: #selector(handleFindRecipesButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupUserImageView()
        setupTitleLabel()
        setupSelectedIngredientsLabel()
        setupFindRecipesButton()
        setupResetButton()
        setupSearchBar()
        setupTableView()
        configure()
        
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
        
        NSLayoutConstraint.activate([
            selectedIngredientsLabel.topAnchor.constraint(equalTo: ingredientsVC.view.topAnchor, constant: 10),
            selectedIngredientsLabel.leadingAnchor.constraint(equalTo: ingredientsVC.view.leadingAnchor, constant: 10),
            selectedIngredientsLabel.heightAnchor.constraint(equalToConstant: 20),
            selectedIngredientsLabel.widthAnchor.constraint(equalToConstant: 160),
            
            ingredientsVC.stackView.leadingAnchor.constraint(equalTo: selectedIngredientsLabel.trailingAnchor, constant: 10),
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
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ingredientsVC.view.frame.height, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset


        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: ingredientSearchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let ingredient = searchBar.text, !ingredient.isEmpty {
            ingredients.append(ingredient)
            searchBar.text = ""
            tableView.reloadData()
            ingredientsVC.addIngredient(ingredient)
        }
        searchBar.resignFirstResponder()
    }
    
    @objc func handleResetButtonTap() {
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    @objc func handleFindRecipesButtonTap() {
        // Fetch recipes with ingredients and present new view controller
    }
}

extension FridgeVC {
    
    func configureCollectionView() {
            let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
            view.addSubview(collectionView)
            collectionView.delegate = self
            collectionView.backgroundColor = .systemBackground
            collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        }
    }

