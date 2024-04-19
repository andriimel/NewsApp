//
//  NewsManager.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/29/24.
//

//
//  NewsManager.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/29/24.
//

import UIKit
import Foundation
import CoreData


class NetworkNewsManager {
    
    static let shared = NetworkNewsManager()
    let myAPIkey = "de95bb98581645e39e35356ad155a46d"
    let cache = NSCache<NSString, UIImage>()
    
    func getApiData(forCategory category: String, completed:@escaping (Result< [Article], NAError>) -> (Void)) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=\(myAPIkey)"
        
        guard let url = URL(string: urlString) else {
            completed(.failure(NAError.invalidResponse))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(NAError.networkIssue))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(NAError.networkIssue))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Response.self, from: data)
                
                completed(.success(jsonData.articles))
                
            } catch {
                completed(.failure(NAError.networkIssue))
            }
        }
        task.resume()
    }
    
    func downloadImage (from urlString: String?, completed:@escaping (UIImage?) -> Void){
        
        guard let downloadURL = urlString else {
            completed(Images.emptyImage)
            return
        }
        
        let cacheKey = NSString(string: downloadURL)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: downloadURL) else {
            completed(nil)
            return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
            error == nil,
            let   response = response as? HTTPURLResponse, response.statusCode == 200,
            let data = data,
            let image = UIImage(data: data)
            else {
                completed(nil)
                return
                }
           
            cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
        
    }
    
    
}
