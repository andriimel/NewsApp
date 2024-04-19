//
//  NALogoLabel.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/30/24.
//

import UIKit

class NALogoLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = UIColor.black
        font = UIFont.boldSystemFont(ofSize: 35.0)
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
