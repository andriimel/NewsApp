//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/25/24.
//

import UIKit
import CoreData
import SwiftUI

class FavoriteViewController: UIViewController{
    
    let tableView               = UITableView()
    var favorites : [Article]  = []
    var filterFavorite : [Article] = []
    let searchController = UISearchController()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .systemRed
        configureTableView()
        configureSearchController()
        getFavorites()
    }
    func configureTableView () {
        view.addSubview(tableView)
        tableView.frame             = view.bounds
        tableView.rowHeight         = 80
        tableView.delegate          = self
        tableView.dataSource        = self
        
        tableView.register(NAFavoriteCell.self, forCellReuseIdentifier: NAFavoriteCell.cellIdentifier)
    }
    
    func getFavorites() {
        
        FavoriteManager.retrieveFavorites { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                   print("Error fav list is empty !!!!")
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                self.favorites = favorites
            case .failure(let error):
                print ("Error !!!! ")
            }
        }
    }

    func configureSearchController() {
    
        //let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension FavoriteViewController:  UITableViewDelegate, UITableViewDataSource, FavoriteCellDelegate {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let activeFavorites = isSearching ? filterFavorite : favorites
        return activeFavorites.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: NAFavoriteCell.cellIdentifier) as! NAFavoriteCell
        
        let activeFavorites = isSearching ? filterFavorite : favorites
        print("ButtonwithIndex\(indexPath.row)",cell.newsSourceLabel.frame.width)
        cell.delegate = self
        let favorite = activeFavorites[indexPath.row]
        cell.set(article: favorite)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tableView. = false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favorite = favorites[indexPath.row]
        
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        FavoriteManager.updateWith(favorite: favorite, actionType: .remove) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else { return}
               
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        tableView.deselectRow(at: indexPath, animated: true)
        presentSafari(with: favorites[indexPath.row].url!)
    }
    
    func share(on cell: NAFavoriteCell) {
        guard  let indexPath = tableView.indexPath(for: cell) else {
        return
        }
        guard let newsUrl = favorites[indexPath.row].url else {
            return
        }
        let ac = UIActivityViewController(activityItems: [newsUrl], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
}

extension FavoriteViewController : UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
       
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        
        isSearching = true
        let filterData = favorites.filter{$0.source.name.lowercased().contains(filter.lowercased())}
        filterFavorite = filterData
        tableView.reloadData()
 
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        tableView.reloadData()
    }
}
