//
//  NASourceLabel.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/30/24.
//

import UIKit

class NASourceLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = .darkGray
        textAlignment = .center
        font = .systemFont(ofSize: 15, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
