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
        switch bookmarksVC?.categoryMapping {
        case 0:
            
        default:
            break
        }
        let destVC = RecipeResultsVC(category: selectedCategory.tag)
        navigationController?.pushViewController(destVC, animated: true)
    }
}
