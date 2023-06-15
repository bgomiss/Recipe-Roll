//
//  RecipesVC.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class FridgeVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
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
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleResetButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let findRecipesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find Recipes", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleFindRecipesButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUserImageView()
        setupTitleLabel()
        setupSearchBar()
        setupResetButton()
        setupFindRecipesButton()
        setupTableView()
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
        ingredientSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            ingredientSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            ingredientSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        ingredientSearchBar.delegate = self
    }
    
    private func setupResetButton() {
        self.view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            resetButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupFindRecipesButton() {
        self.view.addSubview(findRecipesButton)
        findRecipesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            findRecipesButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            findRecipesButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            findRecipesButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: ingredientSearchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -20)
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
