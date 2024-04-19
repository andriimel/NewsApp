//
//  ViewController.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/25/24.
//
//
//import UIKit
//import CoreData
//import SwiftUI
//
//class MainViewController: UIViewController, UITabBarControllerDelegate, UIGestureRecognizerDelegate {
//    
//    var newsManager = NewsManager()
//    var articles: [Article] = []
//    var news:[News]?
//    
//    let defaults = UserDefaults.standard
//    var reloadNews : Bool = true
//    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var tabBarVC = UITabBarController()
//    
//    let logoLabel: UILabel = {
//        let label = UILabel()
//        
//        label.textColor = UIColor.black
//        label.font = UIFont.boldSystemFont(ofSize: 35.0)
//        label.textAlignment = .center
//        
//        
//        return label
//    }()
//    
//    let  scienceNewsButton:UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.systemGray2.cgColor
//        button.setTitle("Science", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor.lightGray
//        button.tag = 0
//        return button
//    }()
//    let  sportNewsButton:UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.systemGray2.cgColor
//        button.setTitle("Sport", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor.lightGray
//        button.tag = 1
//        return button
//    }()
//    
//    
//    let  healthNewsButton:UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.systemGray2.cgColor
//        button.setTitle("Health", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor.lightGray
//        button.tag = 2
//        return button
//    }()
//    
//    let  entertaimentNewsButton:UIButton = {
//        let button = UIButton(type: .system)
//        
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.systemGray2.cgColor
//        button.setTitle("Entertainment", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor.lightGray
//        button.tag = 3
//        return button
//    }()
//    
//    let  favoriteNewsButton:UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.systemGray2.cgColor
//        button.setTitle("Favorite", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor.lightGray
//        button.tag = 4
//        return button
//    }()
//    
//    let logoImage:UIImageView = {
//       let imageView = UIImageView()
//        imageView.layer.cornerRadius = 10
//        imageView.image = UIImage(named: "logoNewsimg")
//        return imageView
//    }()
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        let xCoordinate = view.frame.width * 0.1
//        let spaceBtwn = 20.0
//        let buttonWidth = view.frame.width * 0.8
//        let buttonHeight = 50.0
//        
//        logoImage.frame = CGRect(x: xCoordinate, y: view.frame.height * 0.1, width: buttonWidth, height: buttonWidth/2)
//        logoLabel.frame = CGRect(x: xCoordinate,
//                                 y: view.frame.height * 0.35,
//                                 width: buttonWidth,
//                                 height: buttonHeight)
//        
//        scienceNewsButton.frame = CGRect(x: xCoordinate,
//                                         y: view.frame.height * 0.45,
//                                         width: buttonWidth,
//                                         height: buttonHeight)
//        
//        sportNewsButton.frame = CGRect(x: xCoordinate,
//                                       y: scienceNewsButton.frame.maxY + spaceBtwn,
//                                       width: buttonWidth,
//                                       height: buttonHeight)
//        
//        healthNewsButton.frame = CGRect(x: xCoordinate,
//                                        y: sportNewsButton.frame.maxY + spaceBtwn,
//                                        width: buttonWidth,
//                                        height: buttonHeight)
//        entertaimentNewsButton.frame = CGRect(x: xCoordinate,
//                                              y: healthNewsButton.frame.maxY + spaceBtwn,
//                                              width: buttonWidth,
//                                              height: buttonHeight)
//        
//        favoriteNewsButton.frame = CGRect(x: xCoordinate,
//                                          y: entertaimentNewsButton.frame.maxY + spaceBtwn,
//                                          width: buttonWidth,
//                                          height: buttonHeight)
//        
//    }
//    
//    
//    override  func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //tabBarVC.delegate = self
//        
//        view.backgroundColor = .white
//        logoLabel.text = ""
//        logoLabel.textColor = .lightGray
//        logoLabel.font = UIFont.boldSystemFont(ofSize: 50)
//        let titleText = "News Viewer"
//        var index = 0.0
//        
//        for letter in titleText {
//            
//            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) {(timer) in
//                self.logoLabel.text?.append(letter)
//            }
//            index += 1
//        }
//        
//        reloadNews = defaults.bool(forKey: "MyNewsIsReload")
//        
//        view.addSubview(logoImage)
//        view.addSubview(sportNewsButton)
//        view.addSubview(scienceNewsButton)
//        view.addSubview(favoriteNewsButton)
//        view.addSubview(healthNewsButton)
//        view.addSubview(entertaimentNewsButton)
//        view.addSubview(logoLabel)
//        
//        sportNewsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        scienceNewsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        healthNewsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        entertaimentNewsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        favoriteNewsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//      
//     
//    }
// 
//    func setTabBarController () {
//        
//        let scienceVC = UINavigationController(rootViewController: ScienceNewsViewController())
//        let sportVC = UINavigationController(rootViewController: SportNewsViewController())
//        let healthVC = UINavigationController(rootViewController: HealthViewController())
//        let entertaimentVC = UINavigationController(rootViewController: EntertainmentViewController())
//        let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
//        
//        tabBarVC.setViewControllers([scienceVC,sportVC,healthVC,entertaimentVC,favoriteVC], animated: false)
//        
//        
//        let images = ["globe.americas.fill", "figure.run.circle", "cross.case.circle", "star.square.on.square.fill", "heart"]
//        let title = ["Science","Sport","Health","Entertainment","Favorite"]
//        
//        guard let items = tabBarVC.tabBar.items else {
//            return
//        }
//        
//        for x in 0..<items.count {
//            items[x].image = UIImage(systemName: images[x])
//            items[x].title = title[x]
//        }
//        
//        tabBarVC.tabBar.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
//        tabBarVC.tabBar.tintColor = .darkGray
//        tabBarVC.modalPresentationStyle = .fullScreen
//        tabBarVC.tabBar.selectedItem?.badgeColor = .lightGray
//        
//        tabBarVC.tabBar.isUserInteractionEnabled = true
//        
//        // Swipe
//        
//        let leftSwipe = UISwipeGestureRecognizer(target: self  , action: #selector(handleSwipes(_:)))
//        let rightSwipe = UISwipeGestureRecognizer(target: self , action: #selector(handleSwipes(_:)))
//        leftSwipe.direction = .left
//        leftSwipe.numberOfTouchesRequired = 1
//        rightSwipe.numberOfTouchesRequired = 1
//        rightSwipe.direction = .right
//        tabBarVC.view.addGestureRecognizer(leftSwipe)
//        tabBarVC.view.addGestureRecognizer(rightSwipe)
//    }
//
//    // MARK: - Swipe method
//    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer ) {
//        print("You touch me !!! ")
//        if sender.direction == .left {
//            self.tabBarVC.selectedIndex += 1
//        }
//        if sender.direction == .right {
//            self.tabBarVC.selectedIndex -= 1
//        }
//    }
//
//    // MARK: - Button pressed 
//    @objc func buttonPressed(sender:UIButton) {
//        setTabBarController()
//        self.tabBarVC.selectedIndex = sender.tag
//        
//        present(tabBarVC,animated: true)
//        
//    }
//}


 //
 //  ViewController.swift
 //  NewsApp
 //
 //  Created by Andrii Melnyk on 1/25/24.
 //


 import UIKit
 import CoreData
 import SwiftUI

 class MainViewController: UIViewController, UIGestureRecognizerDelegate {
     
     let tabBarVC = UITabBarController()
     
     let scienceButton = NANewsButton(withTitle: "Science", buttonTag: 0)
     let sportButton = NANewsButton(withTitle: "Sport", buttonTag: 1)
     let healthButton = NANewsButton(withTitle: "Health", buttonTag: 2)
     let entertainmentButton = NANewsButton(withTitle: "Entertainment", buttonTag: 3)
     let favoriteButton = NANewsButton(withTitle: "Favorites", buttonTag: 4)
     
     let logoImage = NALogoImageView(frame: .zero)
     
     override  func viewDidLoad() {
     super.viewDidLoad()
         

         configureUIElements()
         configureButton()
     }
     
     func configureButton() {
      
         let buttonArray = [scienceButton, sportButton, healthButton, entertainmentButton, favoriteButton]
         for item in buttonArray{
             item.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
         }
     }

     // MARK: - Button pressed
     @objc func buttonTapped(sender: UIButton) {
         
         let destVC = NATabBarController()
         destVC.selectedIndex = sender.tag
       
         destVC.modalPresentationStyle = .fullScreen
         self.present(destVC, animated: true)

         
         print ("Button pressed !!!!")
     }
     
     func configureUIElements() {
         view.backgroundColor = .systemBackground
        
         view.addSubview(logoImage)
         view.addSubview(scienceButton)
         view.addSubview(sportButton)
         view.addSubview(healthButton)
         view.addSubview(entertainmentButton)
         view.addSubview(favoriteButton)
         
         NSLayoutConstraint.activate([
             logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -25),
             logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             logoImage.heightAnchor.constraint(equalToConstant: 350),
             logoImage.widthAnchor.constraint(equalToConstant: 350),
             
             scienceButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25),
             scienceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -25),
             scienceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
             scienceButton.heightAnchor.constraint(equalToConstant: 50),
             
             sportButton.topAnchor.constraint(equalTo: scienceButton.bottomAnchor, constant: 25),
             sportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -25),
             sportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
             sportButton.heightAnchor.constraint(equalToConstant: 50),
             
             healthButton.topAnchor.constraint(equalTo: sportButton.bottomAnchor, constant: 25),
             healthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -25),
             healthButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
             healthButton.heightAnchor.constraint(equalToConstant: 50),
             
             entertainmentButton.topAnchor.constraint(equalTo: healthButton.bottomAnchor, constant: 25),
             entertainmentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -25),
             entertainmentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
             entertainmentButton.heightAnchor.constraint(equalToConstant: 50),
 //
             favoriteButton.topAnchor.constraint(equalTo: entertainmentButton.bottomAnchor, constant: 25),
             favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -25),
             favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
             favoriteButton.heightAnchor.constraint(equalToConstant: 50)
         ])
     }
     

 }


 
