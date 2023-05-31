//
//  SPTabBarController.swift
//  practice
//
//  Created by aycan duskun on 13.03.2023.
//

import UIKit

class SPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemMint
        UITabBar.appearance().backgroundColor = .systemBackground
        viewControllers = [createHomeNC(), createRecipesNC(), createBookmarksNC(), createProfileNC()]
    }
    
    
    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "HOME"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
 
    func createRecipesNC() -> UINavigationController  {
        let recipesVC = RecipesVC()
        recipesVC.title = "View Recipe"
        recipesVC.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "fork.knife"), tag: 1)
        
        return UINavigationController(rootViewController: recipesVC)
    }
    
    
    func createBookmarksNC() -> UINavigationController  {
        let bookmarksVC = BookmarksVC()
        bookmarksVC.title = "Bookmarks"
        bookmarksVC.tabBarItem = UITabBarItem(title: "Bookmarks", image: UIImage(systemName: "bookmark.fill"), tag: 2)
        
        return UINavigationController(rootViewController: bookmarksVC)
    }
    
    
    func createProfileNC() -> UINavigationController  {
        let profileVC = AuthenticationVC()
        profileVC.title = "View Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        return UINavigationController(rootViewController: profileVC)
    }
}
