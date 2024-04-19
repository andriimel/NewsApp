//
//  LoadDataVC.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/1/24.
//

import UIKit

class NALoadDataVC: UIViewController, NewsAppCellDelegate {
 
    

    let defaults = UserDefaults.standard
    var selected = false
    let tableView = UITableView()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavButton()
    
         selected = defaults.bool(forKey: "btnSelect")
    }
    
   @objc func backButtonTapped() {
       
        let mainVC = MainViewController()
              mainVC.modalPresentationStyle = .fullScreen
              present(mainVC, animated: true)
    }
    
    func configureNavButton () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
       
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame             = view.bounds
        tableView.rowHeight         = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsAppCell.self, forCellReuseIdentifier: NewsAppCell.cellIdentifier)
    }
    
    func getArticles(for tableView : UITableView){
        guard let category = title else {
        return
        }
        NetworkNewsManager.shared.getApiData(forCategory: category) { [weak self] result in
            guard let self = self else {return}
                switch result {
                case .success(let article):
                   
                        self.articles.append(contentsOf: article)
                        self.articles.removeAll(where: {$0.title == "[Removed]"})
                        DispatchQueue.main.async { tableView.reloadData() }
                    
                case .failure(_):
                    print("ERROR!!!!")
            }
        }
    }
}

extension NALoadDataVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articles.count)
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsAppCell.cellIdentifier, for: indexPath as IndexPath) as! NewsAppCell
        

        cell.delegate = self
       // cell.likeButton.tag = indexPath.row
        let article = articles[indexPath.row]
        cell.set(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        presentSafari(with: articles[indexPath.row].url!)
    }

    
    func didTapLikeButton(on cell: NewsAppCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        // tableView.reloadRows(at: [indexPath], with: .none)
        let article = Article(source: articles[indexPath.row].source, title: articles[indexPath.row].title, url: articles[indexPath.row].url ,urlToImage: articles[indexPath.row].urlToImage )
        
        FavoriteManager.updateWith(favorite: article, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.presentNAAlertOnMainThread(title: "Success!", message: "News added to favorite list !!!", buttonTitle: "OK")
                return
            }
            self.presentNAAlertOnMainThread(title: "Sorry !!!", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
    //  print(indexPath.row)
    
}


