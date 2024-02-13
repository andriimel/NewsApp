//
//  BeautyViewController.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/25/24.
//

import UIKit
import CoreData


class HealthViewController: UIViewController {
    private  var newsTableView: UITableView!
    var newsManager = NewsManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var news:[News]?
    var articles: [Article] = []
    var healthNewsIsAdded = false
    var defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
      
        fetchNews()
        super.viewWillAppear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Health"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .done, target: self, action: #selector(reloadNews))
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
        
        let barHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        newsTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        newsTableView.register(NewsAppCell.self,forCellReuseIdentifier:  NewsAppCell.identifier)
        newsTableView.rowHeight = 80
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        self.view.addSubview(newsTableView)
        healthNewsIsAdded = defaults.bool(forKey: Constant.KeyValue.health)
        
        fetchNews()
        if healthNewsIsAdded == false {
            addNews(with: Constant.healthNews)
        }
       
        
        super.viewDidLoad()
    }
    
    @objc func backButtonPressed() {
        print ("back button pressed")
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
        
    }
    // MARK: - Core data methods
    
    func addNews(with category: String){
       
        DispatchQueue.main.async {
            
            self.newsManager.getApiData(forCategory: Constant.healthNews) { apiData in
                self.articles = apiData
                
                for index in 0..<self.articles.count {
                    
                    let newNews = News(context: self.context)
                    
                    newNews.titleName = self.articles[index].title
                    newNews.newsSourceName = self.articles[index].source.name
                    newNews.newsUrl = self.articles[index].url
                    newNews.imageUrl = self.articles[index].urlToImage
                    newNews.newsType = category
                    newNews.isLike   = false
                    
                    self.news?.append(newNews)
                    self.newsTableView.reloadData()
                    self.saveNews()
                    
                }
                
                self.fetchNews()
            }
            }
        
        healthNewsIsAdded = true
        defaults.set(healthNewsIsAdded, forKey: Constant.KeyValue.health)
       
    }
   
    
    @objc func reloadNews() {
       
        DispatchQueue.main.async {
        
            self.deleteNews()
        }
        self.newsManager.getApiData(forCategory: Constant.healthNews) { apiData in
            self.articles = apiData
            
            for index in 0..<self.articles.count {
              
                let newNews = News(context: self.context)
                newNews.titleName = self.articles[index].title
                newNews.newsSourceName = self.articles[index].source.name
                newNews.newsUrl = self.articles[index].url
                newNews.imageUrl = self.articles[index].urlToImage
                newNews.newsType = Constant.healthNews
                newNews.isLike   = false
                
            }
            self.saveNews()
            self.fetchNews()
        }
        
    }
    
    func saveNews () {
        do {
            try self.context.save()
            print("Data is saved to database !!! ",self.context)
        }
        catch {
            print("Problem with adding data to coreData",error)
        }
    }
    
    
    func deleteNews() {
        
        self.articles.removeAll()
       
        do {
            let request: NSFetchRequest<News> = News.fetchRequest()
            let pred = NSPredicate(format: "newsType == %@",Constant.healthNews)
            request.predicate = pred
            
            news = try context.fetch(request)
          
            for index in 0..<news!.count {
                news![index].isLike = true
                context.delete(news![index])
            }
           
        } catch {
            print("Issues with deleting datas from database", error)
        }
    }
   
    func fetchNews() {
        // Fetch the data from CoreData to display
        
        let request = News.fetchRequest() as NSFetchRequest<News>
        let predicate = NSPredicate(format: "newsType == %@",Constant.healthNews)
        request.predicate = predicate
        
        do {
            news = try context.fetch(request)
            
        } catch {
            print("Error loading categories \(error)")
        }
        
        newsTableView.reloadData()
        
    }
   
}



extension HealthViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = news![indexPath.row].newsUrl  else {
            let alert = UIAlertController(title: "Ooops", message: "Do you want to reload news ?  ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reload news", style: .default, handler: { action in
                self.reloadNews()
            }))
            present(alert, animated: true)
            
            return}
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsAppCell.identifier, for: indexPath as IndexPath) as! NewsAppCell
        
        cell.healthCell = self

        let newNews = news![indexPath.row]
        cell.load(news: newNews)

        return cell
    }
    
    func healthLikeNewsButtonPressed(cell : UITableViewCell){
      
        let indexPathTapped = newsTableView.indexPath(for: cell)
        
        news![indexPathTapped!.row].isLike = !news![indexPathTapped!.row].isLike
        newsTableView.reloadRows(at: [indexPathTapped!], with: .fade)
        
        let favNews = Favorite(context: self.context)
        favNews.favorites = news![indexPathTapped!.row]
        favNews.title =  news![indexPathTapped!.row].titleName
        favNews.source = news![indexPathTapped!.row].newsSourceName
        favNews.url = news![indexPathTapped!.row].newsUrl
        favNews.imgURL = news![indexPathTapped!.row].imageUrl

    saveNews()
        newsTableView.reloadData()
    }
}


    

