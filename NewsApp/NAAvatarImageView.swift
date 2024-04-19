//
//  NAAvatarImageView.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/30/24.
//

import UIKit

class NAAvatarImageView: UIImageView {

  

//        let emptyImage = UIImage(systemName: "")
        
        override init(frame: CGRect) {
            super.init(frame: frame)
           
            configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configure() {
            
            clipsToBounds = true
            layer.cornerRadius = 10
            layer.borderColor = UIColor.darkGray.cgColor
            layer.borderWidth = 1
            backgroundColor = .systemBackground
            image = UIImage(named: "logoImage")
            translatesAutoresizingMaskIntoConstraints = false
        }
    }



