//
//  QueryRecipesVCViewController.swift
//  practice
//
//  Created by aycan duskun on 12.06.2023.
//

import UIKit

class QueryRecipesVC: UIViewController {
    
    var searchText: String?
    private let tableView = UITableView()
    var searchResults: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureUI()
        updateUI()
        view.backgroundColor = .systemPink
    }
    
    
    func updateUI() {
        guard let query = searchText else {return}
        
        NetworkManager.shared.getRecipesInfo(for: .searhRecipes(query)) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self.searchResults = recipes
                    self.tableView.reloadData()
                    //self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(RecipesCell.self, forCellReuseIdentifier: RecipesCell.reuseID)
    }
    
    
    private func configureUI() {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    
    func reloadTableView() {
            tableView.reloadData()
        }
    }


extension QueryRecipesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipesCell.reuseID) as! RecipesCell
        let recipe = searchResults[indexPath.row]
        cell.set(recipe: recipe)
        return cell
    }
}
