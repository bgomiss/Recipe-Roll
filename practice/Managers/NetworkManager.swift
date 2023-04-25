//
//  NetworkManager.swift
//  practice
//
//  Created by aycan duskun on 14.03.2023.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?instructionsRequired=true&fillIngredients=false&addRecipeInformation=true&&sortDirection=asc&offset=0&number=2&limitLicense=false&ranking=2&type="
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getCategoriesInfo(for tags: String, completed: @escaping (Result<[Recipe], SPError>) -> Void) {
        let endpoint = baseURL + "\(tags)\(Api.apiKey)"
        
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
                let recipes = try decoder.decode(RecipeResults.self, from: data)
                completed(.success(recipes.results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?, Bool) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image, true)
            return
        }
        guard let url = URL(string: urlString) else {
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
