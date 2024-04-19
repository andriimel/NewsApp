//
//  NATabBarController.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/30/24.
//

import UIKit

class NATabBarController: UITabBarController {

    
    let images = ["globe.americas.fill", "figure.run.circle", "cross.case.circle", "star.square.on.square.fill", "heart"]
    let titles = ["Science","Sports","Health","Entertainment","Favorite"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = .fullScreen
      
        UITabBar.appearance().tintColor = .darkGray
        self.setViewControllers([createScienceVC(), createSportVC(),createHealthVC(),createEntertainmentVC(),createFavoriteVC()], animated: true)
    }
    

   
    func createScienceVC() -> UINavigationController {
        
        let scienceVC = ScienceNewsViewController()
        scienceVC.title = "Science"
        scienceVC.modalPresentationStyle = .fullScreen
        scienceVC.tabBarItem.image = UIImage(systemName: images[0])
        scienceVC.tabBarItem.tag = 0
        return UINavigationController(rootViewController: scienceVC)
    }
    
    func createSportVC() -> UINavigationController{
        
        let sportVC = SportNewsViewController()
        sportVC.title = "Sports"
        sportVC.tabBarItem.image = UIImage(systemName: images[1])
        sportVC.tabBarItem.tag = 1
        return UINavigationController(rootViewController: sportVC)
    }
    func createHealthVC() -> UINavigationController {
        let healthVC = HealthViewController()
        healthVC.title = "Health"
        healthVC.tabBarItem.image = UIImage(systemName: images[2])
        healthVC.tabBarItem.tag = 2
        return UINavigationController(rootViewController: healthVC)
    }
    func createEntertainmentVC() -> UINavigationController {
        let entertainmentVC = EntertainmentViewController()
        entertainmentVC.title = "Entertainment"
        entertainmentVC.tabBarItem.image = UIImage(systemName: images[3])
        entertainmentVC.tabBarItem.tag = 3
        return UINavigationController(rootViewController: entertainmentVC)
    }
    
    func createFavoriteVC() -> UINavigationController {
        let favoriteVC = FavoriteViewController()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem.image = UIImage(systemName: images[4])
        favoriteVC.tabBarItem.tag = 4
        return UINavigationController(rootViewController: favoriteVC)
    }
    
}
