//
//  InstructionsVC.swift
//  practice
//
//  Created by aycan duskun on 26.04.2023.
//

import UIKit

class InstructionsVC: UIViewController {
    
    var recipe: Recipe?
    var ingredients: [Ent]?
    let tableView = UITableView()
    var instructions: [Recipe] = []
    var ingredientsArray: [Ent] = []
    var stepsArray: [SimplifiedStep] = []
    var comments: [Comment] = []
//    let recipeImage    = SPImageView(frame: .zero)
    
    
    init(recipe: Recipe, ingredients: [Ent], steps: [SimplifiedStep]) {
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
        self.ingredients = ingredients
        self.stepsArray = steps
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
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(InstructionsCell.self, forCellReuseIdentifier: InstructionsCell.reuseID)
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.reuseID)
        tableView.register(StepsCell.self, forCellReuseIdentifier: StepsCell.reuseID)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseID)
        tableView.register(CommentsHeaderView.self, forHeaderFooterViewReuseIdentifier: CommentsHeaderView.reuseID)
    }
    
    
    func updateUI() {
        guard let recipe = recipe, let ingredients = ingredients else {return}
        instructions = [recipe]
        ingredientsArray = ingredients
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension InstructionsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return comments.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsCell.reuseID) as! InstructionsCell
        let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.reuseID) as! IngredientsCell
        let stepsCell = tableView.dequeueReusableCell(withIdentifier: StepsCell.reuseID) as! StepsCell
        
        if indexPath.row == 0 {
            let recipe = instructions[0]
            cell.setFeaturesCell(recipe: recipe)
            return cell
        } else if indexPath.row == 1 {
            let description = instructions[0]
            cell.setDescriptionCell(recipe: description)
            return cell
        } else if indexPath.row == 2 {
            ingredientsCell.setIngredientsCell(ingredients: ingredientsArray)
            return ingredientsCell
        } else {
            stepsCell.setInstructionsCell(steps: stepsArray)
            return stepsCell
        }
        
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
            let comment = comments[indexPath.row]
            cell.userImageView.image = // Load user image from URL
            cell.commentLabel.text = "\(comment.userName): \(comment.commentText)"
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CommentsHeaderView.reuseID) as! CommentsHeaderView
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100 // Height for InstructionsCell
        } else if indexPath.row == 1 {
            return UITableView.automaticDimension // Default height for other cases
        } else if indexPath.row == 2 {
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
}
