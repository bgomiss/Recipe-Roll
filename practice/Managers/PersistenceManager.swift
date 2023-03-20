//
//  PersistenceManager.swift
//  practice
//
//  Created by aycan duskun on 19.03.2023.
//

import Foundation

enum PersistenceActionType {
    case add
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys { static let categories = "categories" }
    
    static func updateWith(category: Recipes, actionType: PersistenceActionType, completed: @escaping(SPError?) -> Void) {
        retrievedCategories { result in
            switch result {
            case .success(var categories):
                
                switch actionType {
                case .add:
                    guard !categories.contains(category) else {
                        completed(.alreadyInCategories)
                        return
                    }
                    
                    categories.append(category)
                }
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrievedCategories(completed: @escaping (Result<[Recipes], SPError>) -> Void) {
        guard let categoriesData = defaults.object(forKey: Keys.categories) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let categories = try decoder.decode([Recipes].self, from: categoriesData)
            completed(.success(categories))
        } catch {
            completed(.failure(.unableToCategory))
        }
                
    } 
}
