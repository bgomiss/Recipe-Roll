//
//  NetworkManager.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getResults(for query: String, completed: @escaping (Result<Recipe, SPError>) -> Void) {
        let endpoint = baseURL + "query=\(query)&rapidapi-key=76d66bbeebmsheefcdd9555def70p17b61djsn4d50d52f9d2f"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidQuery))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode(Recipe.self, from: data)
                completed(.success(recipes))
                print(recipes)
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
