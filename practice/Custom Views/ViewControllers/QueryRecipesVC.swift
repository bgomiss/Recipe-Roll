//
//  QueryRecipesVCViewController.swift
//  practice
//
//  Created by aycan duskun on 12.06.2023.
//

import UIKit

class QueryRecipesVC: UIViewController {
    
    
    private let tableView = UITableView()
    private var searchResults: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureUI()
        view.backgroundColor = .systemPink
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipesCell.reuseID) as! RecipesCell
        return cell
    }
}
