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
        viewControllers = [createHomeNC(), createCategoriesNC(), createRecipesNC(), createShopListNC(), createProfileNC()]
    }
    
    
    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "HOME"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createCategoriesNC() -> UINavigationController {
        let categoriesVC = CategoriesVC()
        categoriesVC.title = "CATEGORIES"
        categoriesVC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "square.split.2x2.fill"), tag: 1)
        
        return UINavigationController(rootViewController: categoriesVC)
    }
    
    
    func createRecipesNC() -> UINavigationController  {
        let recipesVC = RecipesVC()
        recipesVC.title = "View Recipe"
        recipesVC.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "fork.knife"), tag: 2)
        
        return UINavigationController(rootViewController: recipesVC)
    }
    
    
    func createShopListNC() -> UINavigationController  {
        let shopListVC = ShoppingListVC()
        shopListVC.title = "Shopping List"
        shopListVC.tabBarItem = UITabBarItem(title: "Shopping", image: UIImage(systemName: "cart"), tag: 3)
        
        return UINavigationController(rootViewController: shopListVC)
    }
    
    
    func createProfileNC() -> UINavigationController  {
        let profileVC = ProfileVC()
        profileVC.title = "View Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 4)
        
        return UINavigationController(rootViewController: profileVC)
    }
}
