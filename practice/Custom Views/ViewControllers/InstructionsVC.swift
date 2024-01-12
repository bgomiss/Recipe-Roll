//
//  InstructionsVC.swift
//  practice
//
//  Created by aycan duskun on 26.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class InstructionsVC: UIViewController {
    
    var recipe: Recipe?
    var recommendedRecipe: Instructions?
    var ingredients: [Ent]?
    var recommendedIngredients: [Ingredients]?
    var recommendedIngredientsArray: [Ingredients] = []
    let tableView = UITableView()
    let bookmarkIcon = UIImageView()
    var instructions: [Recipe]? = []
    var recommendedRecipeInstructions: [Instructions]? = []
    var ingredientsArray: [Ent] = []
    var stepsArray: [SimplifiedStep] = []
    var comments: [Comment] = []
    let db = Firestore.firestore()
    
    
    init(recipe: Recipe? = nil, recommendedRecipe: Instructions? = nil, ingredients: [Ent]? = [], recommendedIngredients: [Ingredients]? = nil, steps: [SimplifiedStep]) {
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
        self.recommendedRecipe = recommendedRecipe
        self.ingredients = ingredients
        self.recommendedIngredients = recommendedIngredients
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
        setupBookmarkButton()
        recentlyViewed()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),  name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    deinit { NotificationCenter.default.removeObserver(self)}
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    func setupBookmarkButton() {
        let bookmarkIcon = UIImage(systemName: "bookmark.fill") // replace this with your bookmark image
        let bookmarkButton = UIBarButtonItem(image: bookmarkIcon, style: .plain, target: self, action: #selector(bookmarkButtonTapped))
        self.navigationItem.rightBarButtonItem = bookmarkButton
    }
    
    
    @objc func bookmarkButtonTapped() {
        
        if Auth.auth().currentUser == nil {
            // No user is signed in.
            let alertVC = SPAlertVC(title: "Please Signin", message: "To save the recipes of your like to the related categories please signin or signup and get the most use of the app", buttonTitle: "Ok")
            alertVC.completionHandler = {
//                let destVC = WelcomeVC()
//                self.present(destVC, animated: true)
                
            }
            present(alertVC, animated: true, completion: nil)
        } else {
            guard let displayedRecipe = RecipeResultsVC.displayedRecipe else {return}
            
            let bookmark = ["id": displayedRecipe.id,
                            "title": displayedRecipe.title,
                            "image": displayedRecipe.image,
                            "viewedTimeStamp": FieldValue.serverTimestamp()] as [String : Any]
            
            
            guard let category = RecipeResultsVC.category else {return}
            
            let userID = Auth.auth().currentUser!.uid // get user ID
            
            let userBookmarksCollection = db.collection("bookmarks").document(userID).collection("categories")
            userBookmarksCollection.document(category).setData([String(displayedRecipe.title) : bookmark], merge: true) { err in
                
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added successfully")
//                    DispatchQueue.main.async {
//                        NotificationCenter.default.post(name: NSNotification.Name("BookmarkAddedNotification"), object: nil)
//
//                    }
                }
            }
            
            let query = userBookmarksCollection.order(by: "viewedTimeStamp", descending: false).limit(to: 1)
            query.getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if data.count >= 30 {
                            // Get the id of the oldest recipe
                            let oldestRecipeId = document.documentID

                            // Delete the oldest recipe
                            userBookmarksCollection.document(oldestRecipeId).delete() { err in
                                if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    print("Document successfully removed!")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
        
    func recentlyViewed() {
        if Auth.auth().currentUser == nil {
            // No user is signed in.
            let alertVC = SPAlertVC(title: "Please Signin!", message: "To save the recipes of your like to the related categories please signin or signup and get the most use of the app", buttonTitle: "Ok")
            alertVC.completionHandler = {
//                let destVC = WelcomeVC()
//                self.present(destVC, animated: true)
                
            }
            present(alertVC, animated: true, completion: nil)

        } else {
            guard let displayedRecipe = RecipeResultsVC.displayedRecipe else {return}
            
            let bookmark = ["id": displayedRecipe.id,
                            "title": displayedRecipe.title,
                            "image": displayedRecipe.image,
                            "viewedTimeStamp": FieldValue.serverTimestamp()] as [String : Any]
            
            let userID = Auth.auth().currentUser!.uid // get user ID
            
            let userBookmarksCollection = db.collection("bookmarks").document(userID).collection("categories")
                        userBookmarksCollection.document("Recently Viewed").setData([String(displayedRecipe.title) : bookmark], merge: true) { err in
               
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added successfully")
//                    DispatchQueue.main.async {
//                        NotificationCenter.default.post(name: NSNotification.Name("BookmarkAddedNotification"), object: nil)
//
//                    }
                }
            }
            
            let query = userBookmarksCollection.order(by: "viewedTimeStamp", descending: false).limit(to: 1)
            query.getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if data.count >= 30 {
                            // Get the id of the oldest recipe
                            let oldestRecipeId = document.documentID

                            // Delete the oldest recipe
                            userBookmarksCollection.document(oldestRecipeId).delete() { err in
                                if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    print("Document successfully removed!")
                                }
                            }
                        }
                    }
                }
            }
        }
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
        guard let recipe = recipe,
              let ingredients = ingredients,
              let recommendedRecipe = recommendedRecipe,
              let recommendedIngredients = recommendedIngredients
        else {return}
        instructions = [recipe]
        ingredientsArray = ingredients
        recommendedRecipeInstructions = [recommendedRecipe]
        recommendedIngredientsArray = recommendedIngredients
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
        switch indexPath.section {
           case 0:
               if indexPath.row == 0 {
                   let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsCell.reuseID) as! InstructionsCell
                   if instructions != nil {
                       guard let recipe = instructions?[0] else { return cell }
                       cell.setFeaturesCell(recipe: recipe)
                   } else {
                       guard let recipe = recommendedRecipeInstructions?[0] else { return cell }
                       cell.setFeaturesCell(recommendedRecipe: recipe)
                   }
                   
                   return cell
               } else if indexPath.row == 1 {
                   let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsCell.reuseID) as! InstructionsCell
                   guard let description = instructions?[0] else { return cell }
                   cell.setDescriptionCell(recipe: description)
                   return cell
               } else if indexPath.row == 2 {
                   let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.reuseID) as! IngredientsCell
                   ingredientsCell.setIngredientsCell(ingredients: ingredientsArray)
                   return ingredientsCell
               } else {
                   let stepsCell = tableView.dequeueReusableCell(withIdentifier: StepsCell.reuseID) as! StepsCell
                   stepsCell.setInstructionsCell(steps: stepsArray)
                   return stepsCell
               }
           case 1:
               let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
               let comment = comments[indexPath.row]
               cell.userImageView.image = UIImage(named: "appicon")
               cell.commentLabel.text = "cok guzel dodo" //"\(comment.userName): \(comment.commentText)"
               return cell
           default:
               fatalError("Invalid section")
           }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CommentsHeaderView.reuseID) as! CommentsHeaderView
            return headerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
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
