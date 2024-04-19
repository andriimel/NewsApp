//
//  NALikeButton.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/1/24.
//

import UIKit

class NALikeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    
        UIButton(type: .custom)
        setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        tintColor = UIColor.systemRed
        translatesAutoresizingMaskIntoConstraints = false
    }
}
