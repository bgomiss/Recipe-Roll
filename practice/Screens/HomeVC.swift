//
//  ViewController.swift
//  practice
//
//  Created by aycan duskun on 12.03.2023.
//

import UIKit


class HomeVC: UIViewController {
    
    let titleLabel              = SPTitleLabel(textAlignment: .left, fontSize: 20)
    let queryTextField          = SPTextField()
    let tableView               = UITableView()
    let tvCell                  = CategoriesTableViewCell()
    var recipes: [Recipes]      = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(queryTextField, titleLabel)
        layoutUI()
        getCategories(query: "pasta")
        configureUIElements()
        configureTableView()
        createDismissKeyboardTapGesture()
        print(recipes)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        queryTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func getCategories(query: String) {
        NetworkManager.shared.getCategoriesInfo(for: query) { [weak self] category in
            
            guard let self = self else { return }
            
            switch category {
            case .success(let categories):
                //print(categories)
                self.updateUI(with: categories)
            case .failure(let error):
                return
            }
        }
    }
    
//    func getCategories() {
//        PersistenceManager.retrievedCategories { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let categories):
//                self.updateUI(with: categories)
//
//            case .failure(let error):
//                return
//            }
//        }
//    }

    
    func configureTableView() {
        view.addSubviews(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: queryTextField.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.backgroundColor = .systemMint
        tableView.rowHeight = 15
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "CategoriesTableViewCell")
    }
    
    
    func updateUI(with categories: [Recipes]) {
        recipes.append(contentsOf: categories)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureUIElements() {
        titleLabel.text = "What would you like to cook today?"
    }
    
    func layoutUI() {
        queryTextField.delegate = self
        
        NSLayoutConstraint.activate([
            queryTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            queryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            queryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            queryTextField.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            titleLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}


extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        queryTextField.resignFirstResponder()
    }
}


extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        if recipes.isEmpty == false {
            cell.recipes = recipes
            cell.collectionView.reloadData()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


