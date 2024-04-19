//
//  NANewsLabel.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/30/24.
//

import UIKit

class NANewsLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = .darkGray
        textAlignment = .left
        numberOfLines = 0
        font = .systemFont(ofSize: 12, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
