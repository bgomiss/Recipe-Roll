//
//  InstructionsVC.swift
//  practice
//
//  Created by aycan duskun on 26.04.2023.
//

import UIKit

class InstructionsVC: UIViewController {
    
    var recipe: Recipe?
    let tableView = UITableView()
    var instructions: [Recipe] = []
//    let recipeImage    = SPImageView(frame: .zero)
    
    
    init(recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
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
//        view.addSubview(recipeImage)
//        recipeImage.downloadImage(fromURL: recipe!.image)
//        recipeImage.frame = view.bounds
        view.backgroundColor = .systemBackground
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        //tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(InstructionsCell.self, forCellReuseIdentifier: InstructionsCell.reuseID)
    }
    
    
    func updateUI() {
        guard let recipe = recipe else {return}
        instructions = [recipe]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension InstructionsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsCell.reuseID) as! InstructionsCell
        
        if indexPath.row == 0 {
            let recipe = instructions[0]
            cell.setFeaturesCell(recipe: recipe)
            return cell
        } else if indexPath.row == 1 {
            let description = instructions[0]
            cell.setDescriptionCell(recipe: description)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100 // Height for InstructionsCell
        } else {
            return UITableView.automaticDimension
        }
    }
}