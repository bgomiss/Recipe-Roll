//
//  NetworkManager.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import UIKit

class NetworkManager {
    
    enum Endpoint {
       case searchCategory(String)
       case bookmarks(String)
        var url: String {
                switch self {
                case .searchCategory(let category):
                    return "https://api.spoonacular.com/recipes/complexSearch?instructionsRequired=true&fillIngredients=false&addRecipeInformation=true&&sortDirection=asc&offset=0&number=10&limitLicense=false&ranking=2&type=\(category)&apiKey=\(Api.apiKey)"
                case .bookmarks(let recipeID):
                    return "https://api.spoonacular.com/recipes/\(recipeID)/information?apiKey=\(Api.apiKey)"
                }
            }
    }
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    
    
    private init() {}
    
    func getRecipesInfo(for endpoint: Endpoint, completed: @escaping (Result<[Recipe], SPError>) -> Void) {
        
        guard let url = URL(string: endpoint.url) else {
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
                switch endpoint {
                case .searchCategory(_):
                    let recipes = try decoder.decode(RecipeResults.self, from: data)
                    completed(.success(recipes.results))
                case .bookmarks(_):
                    let recipes = try decoder.decode(Recipe.self, from: data)
                    completed(.success([recipes]))
                }
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?, Bool) -> Void) {
        let cacheKey = NSString(string: urlString)
        let updatedURLString = urlString.replacingOccurrences(of: "312x231", with: "636x393")
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image, true)
            return
        }
        guard let url = URL(string: updatedURLString) else {
            completed(nil, false)
            return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                    error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200,
                    let data = data,
                    let image = UIImage(data: data) else {
                    completed(nil, false)
                return
            }
         
            self.cache.setObject(image, forKey: cacheKey)
            completed(image, false)
        }
        task.resume()
    }
}
