//
//  UIViewController+Extension.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/1/24.
//

import UIKit
import SafariServices

fileprivate var containerView : UIView!

extension UIViewController {
//    
 func   presentNAAlertOnMainThread(title: String, message: String, buttonTitle: String) {
     
     DispatchQueue.main.async {
         let alertVC = NAAlertVC(title: title, message: message, buttonTitle: buttonTitle)
         alertVC.modalPresentationStyle = .overFullScreen
         alertVC.modalTransitionStyle = .crossDissolve
         self.present(alertVC, animated: true)
     }
    }
 
    func presentSafari(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .darkGray
        present(safariVC, animated: true)
    }
    

}
