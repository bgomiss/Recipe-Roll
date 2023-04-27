//
//  RecipeResultsVC.swift
//  practice
//
//  Created by aycan duskun on 25.04.2023.
//

import UIKit

class RecipeResultsVC: UIViewController {
    
    var category: String?
    let tableView = UITableView()
    var recipeResults: [Recipe] = []
    
    
    init(category: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()
        updateUI()
        }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        self.navigationItem.title = category
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RecipesCell.self, forCellReuseIdentifier: RecipesCell.reuseID)
    }
    
    
    func updateUI() {
        guard let category = category else {return}
        NetworkManager.shared.getCategoriesInfo(for: category) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self.recipeResults = recipes
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension RecipeResultsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipesCell.reuseID) as! RecipesCell
        let recipe = recipeResults[indexPath.row]
        cell.set(recipe: recipe)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipeResults[indexPath.row]
        let destVC = InstructionsVC(recipe: selectedRecipe)
        let nav = UINavigationController(rootViewController: destVC)
        nav.modalPresentationStyle = .pageSheet
        
        // Create and configure the UISheetPresentationController
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 40
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        present(nav, animated: true)
    }
}
