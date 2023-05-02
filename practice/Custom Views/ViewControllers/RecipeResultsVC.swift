//
//  RecipeResultsVC.swift
//  practice
//
//  Created by aycan duskun on 25.04.2023.
//

import UIKit

class RecipeResultsVC: UIViewController, UISheetPresentationControllerDelegate {
    
    var vc = UIViewController()
    var category: String?
    let tableView = UITableView()
    var recipeResults: [Recipe] = []
    var ingredientsResults: [Ent] = []
    let recipeImage    = SPImageView(frame: .zero)
    
    
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vc.dismiss(animated: true)
        }
    
    
    func extractIngredients(from analyzedInstructions: [AnalyzedInstruction]) {
        for instruction in analyzedInstructions {
            for step in instruction.steps {
                for ingredient in step.ingredients {
                    let imageURL = "https://spoonacular.com/cdn/ingredients_100x100/\(ingredient.image)"
                    let newIngredient = Ent(id: ingredient.id, name: ingredient.name, localizedName: ingredient.localizedName, image: imageURL, temperature: ingredient.temperature)
                    ingredientsResults.append(newIngredient)
                }
            }
        }
    }
    
    
    func setBackgroundImage() {
        view.addSubview(recipeImage)
        //view.sendSubviewToBack(recipeImage)
        //recipeImage.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
                recipeImage.topAnchor.constraint(equalTo: view.topAnchor),
                recipeImage.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 440),
                recipeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                recipeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
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
                    for recipe in recipes {
                        self.extractIngredients(from: recipe.analyzedInstructions)
                    }
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension RecipeResultsVC: UITableViewDataSource, UITableViewDelegate, UIAdaptivePresentationControllerDelegate {
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
        
        // Download and set the full-screen background image
        recipeImage.downloadImage(fromURL: selectedRecipe.image)
        setBackgroundImage()
        
        let ingredientsForSelectedRecipe = ingredientsResults.filter { ingredient in
            return selectedRecipe.analyzedInstructions.contains { analyzedInstruction in
                return analyzedInstruction.steps.contains { step in
                    return step.ingredients.contains { ent in
                        return ent.id == ingredient.id
                    }
                }
            }
        }
        
        let destVC = InstructionsVC(recipe: selectedRecipe, ingredients: ingredientsForSelectedRecipe)
        vc = destVC
        let nav = UINavigationController(rootViewController: destVC)
        nav.modalPresentationStyle = .pageSheet
        
        // Create and configure the UISheetPresentationController
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 40
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.delegate = self
        }
        present(nav, animated: true)
    }
    
    func presentationControllerDidDismiss(_ presantationController: UIPresentationController) {
        UIView.animate(withDuration: 0.7, animations: {
                self.recipeImage.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
            }, completion: { _ in
                self.recipeImage.removeFromSuperview()
            })
    }
}
