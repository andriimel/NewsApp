//
//  PoliticalNewsViewController.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/25/24.
//

import UIKit
import CoreData

class ScienceNewsViewController: NALoadDataVC{
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureTableView()
        getArticles(for: tableView)
    }
    

    
}
