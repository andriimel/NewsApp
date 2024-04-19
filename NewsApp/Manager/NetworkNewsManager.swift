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
}


