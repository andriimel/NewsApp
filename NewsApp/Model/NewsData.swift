//
//  NewsData.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/29/24.
//

import Foundation


struct Response : Codable {
    
    var articles : [Article]
}

struct Article : Codable {
  
    
    var source: Source
    var title: String?
    var url: URL?
    var urlToImage: String?
   
    //var publishedAt: String?
    
}
struct Source : Codable{
    var name: String
    
}

