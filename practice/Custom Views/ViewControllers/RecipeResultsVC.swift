//
//  RecipeResultsVC.swift
//  practice
//
//  Created by aycan duskun on 25.04.2023.
//

import UIKit

class RecipeResultsVC: UIViewController {
    
    let tableView = UITableView()
    var recipeResults: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()
    }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "RECIPES"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RecipesCell.self, forCellReuseIdentifier: RecipesCell.reuseID)
    }
}
