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
    
    
    func didTapSeeAllButton() {
        print("didTapSeeAllButton Tapped")
        //guard let categoryID = bookmarksVC?.categoryMapping.values else {return}
        for section in 0...4 {
            guard let categoryID = bookmarksVC?.getCategoryID(for: section),
                  let index = bookmarksVC?.bookmarkedRecipes.firstIndex(where: { $0.0 == categoryID})
            else  { return }
            // Use categoryID for your logic here
            print("Category ID for section \(section) is \(categoryID)")
            
            let categoryRecipes = bookmarksVC?.bookmarkedRecipes[index].1
            
            //print("CATEGORY IDs: \(categoryID)")
            switch bookmarksVC?.categoryMapping {
            case let mapping? where mapping.keys.contains(0):
                
                let RvRecipes = bookmarksVC?.bookmarkedRecipes[0].1
                //print("RV RECIPES: \(String(describing: RvRecipes))")
                
            case let mapping? where mapping.keys.contains(1):
                
                let madeItRecipes = bookmarksVC?.bookmarkedRecipes[1].1
                //print("RV RECIPES: \(String(describing: madeItRecipes))")
                
            case let mapping? where mapping.keys.contains(2):
                
                let breakfastRecipes = bookmarksVC?.bookmarkedRecipes[2].1
                print("RV RECIPES: \(String(describing: breakfastRecipes))")
                
            default:
                break
            }
            //        let destVC = RecipeResultsVC(category: selectedCategory.tag)
            //        navigationController?.pushViewController(destVC, animated: true)
        }
    }
    
}
