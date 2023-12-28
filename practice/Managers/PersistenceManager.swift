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
    enum Keys {
        static let categories = "categories"
        static let userProfile = "userProfile"
    }
    
    static func updateWith(category: Recipe, actionType: PersistenceActionType, completed: @escaping(SPError?) -> Void) {
        retrievedCategories { result in
            switch result {
            case .success(var categories):
                
                switch actionType {
                case .add:
                    guard !categories.contains(where: { $0 == category }) else {
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
    
    
    static func saveUserProfile(user: User, completed: @escaping (SPError?) -> Void) {
           do {
               let encoder = JSONEncoder()
               let userData = try encoder.encode(user)
               defaults.set(userData, forKey: Keys.userProfile)
               completed(nil)
           } catch {
               completed(.unableToSaveUserProfile)
           }
       }
       
       static func retrieveUserProfile(completed: @escaping (Result<User?, SPError>) -> Void) {
           guard let userData = defaults.object(forKey: Keys.userProfile) as? Data else {
               completed(.success(nil))
               return
           }
           
           do {
               let decoder = JSONDecoder()
               let user = try decoder.decode(User.self, from: userData)
               completed(.success(user))
           } catch {
               completed(.failure(.unableToRetrieveUserProfile))
           }
       }
    
    
    static func retrievedCategories(completed: @escaping (Result<[Recipe], SPError>) -> Void) {
        
        ///
        /// IT IS A BAD BAD IDEA SAVE A LOT DATA IN DEFAULTS, IF YOU HAVE PROBLEMS TO CALL YOUR
        /// CATEGORIES IS BECUASE ALWAYS YOU AR USING DEFAULTS, IF YOU UNINSTALL YOUR APP AND INSTALL
        /// ONE MORE TIME, EVERTHING IS LOADING GOOD, BUT IN THE SECOND OPENING APP IS FAULIING FOR THIS BECAUSE
        /// USER DEFAULT IS NOT SAVING IMAGE DATA
        ///
        /// MY RECOMMENDATION IS: REMOVE THIS AN CONSUME DIRECTLY FROM WEB SERVICES, CACHE METHOD IS FOR ADVANCED
        /// DEVELOPER...
        ///
        
        guard let categoriesData = defaults.object(forKey: Keys.categories) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let categories = try decoder.decode([Recipe].self, from: categoriesData)
            completed(.success(categories))
        } catch {
            completed(.failure(.unableToCategory))
        }
                
    } 
}
