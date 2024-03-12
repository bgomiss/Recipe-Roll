//
//  BookmarksPresenter.swift
//  practice
//
//  Created by aycan duskun on 3.03.2024.
//

import UIKit

class BookmarksPresenter: SeeAllDelegate {
    
    private weak var bookmarksVC: BookmarksVC?
    
    init(bookmarksVC: BookmarksVC?) {
        self.bookmarksVC = bookmarksVC
        bookmarksVC?.delegate = self
    }
    
    
    func didTapSeeAllButton(sender: UIButton) {
        
            let section = sender.tag // Get the section number from the button's tag
            print("See all button tapped for section \(section)")
        
            guard let categoryID = bookmarksVC?.getCategoryID(for: section),
                  let index = bookmarksVC?.bookmarkedRecipes.firstIndex(where: { $0.0 == categoryID})
            else  { return }
            // Use categoryID for your logic here
            print("Category ID for section \(section) is \(categoryID)")
                        
            switch section {
            case 0:
                
                let RvRecipes = bookmarksVC?.bookmarkedRecipes[index].1
                //print("RV RECIPES: \(String(describing: RvRecipes))")
                
            case 1:
                
                let madeItRecipes = bookmarksVC?.bookmarkedRecipes[index].1
                //print("RV RECIPES: \(String(describing: madeItRecipes))")
                
            case 2:
                
                let breakfastRecipes = bookmarksVC?.bookmarkedRecipes[index].1
                print("Breakfast RECIPES: \(String(describing: breakfastRecipes))")
                
            default:
                break
            }
            //        let destVC = RecipeResultsVC(category: selectedCategory.tag)
            //        navigationController?.pushViewController(destVC, animated: true)
        }
    }
    

