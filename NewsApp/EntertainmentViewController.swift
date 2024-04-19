//
//  CultureNewsViewController.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/25/24.
//

import UIKit
import CoreData


class EntertainmentViewController: NALoadDataVC {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        configureTableView()
        getArticles(for: tableView)
    }
}
