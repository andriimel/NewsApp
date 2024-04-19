//
//  NALogoImageView.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/30/24.
//

import UIKit

class NALogoImageView: UIImageView {

   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
       
        layer.cornerRadius = 10
        backgroundColor = .systemBackground
        image = UIImage(named: "logoImage")
        translatesAutoresizingMaskIntoConstraints = false
    }
}

