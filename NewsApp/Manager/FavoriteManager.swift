//
//  FavoriteManager.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/8/24.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum FavoriteManager {
    static private let defaults = UserDefaults.standard
    static var isAdded: Bool = false
    
    enum Keys {
        static let favorites = "favorites"
        static let isAdd = "isAdded"
    }
    
    static func updateWith(favorite: Article, actionType: PersistanceActionType, completed: @escaping (NAError?)-> Void){
        
        retrieveFavorites { result in
            switch result {
            
            case .success(let success):
                var retrivedFavorites = success
                
                switch actionType {
                case .add:
                    guard  !retrivedFavorites.contains(where: {$0.title == favorite.title}) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    defaults.set(true, forKey: Keys.isAdd)
                    retrivedFavorites.append(favorite)
                    break
                case .remove:
                    defaults.set(false, forKey: Keys.isAdd)
                    retrivedFavorites.removeAll{ $0.title == favorite.title}
                }
                completed(save(favorites: retrivedFavorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
   
    static func retrieveFavorites(completed: @escaping (Result<[Article], NAError>) -> Void) {
        
        isAdded = defaults.bool(forKey: Keys.isAdd)
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Article].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Article]) -> NAError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
