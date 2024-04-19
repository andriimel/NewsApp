//
//  NAError.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/31/24.
//

import Foundation

enum NAError : String, Error {
   
    case networkIssue = "You have some problems with your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case unableToFavorite = "There was en error favoriting this user. Please  try again."
    case alreadyInFavorites = "News already in favourites !!! "
}
