//
//  LoadDataVC.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/1/24.
//

import UIKit

class LoadDataVC: UIViewController {

    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func getArticles(){
        guard let category = title else {
        return
        }
        NewsManager.shared.getApiData(forCategory: category) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let article):
                self.articles.append(contentsOf: article)
                print(articles)
                break
                
            case .failure(_):
                print("ERROR!!!!")
            }
        }
    }
 
}
