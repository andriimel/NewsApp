//
//  NAShareButton.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/9/24.
//

import UIKit

class NAShareButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        
    
       
        setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        tintColor = UIColor.darkGray
        translatesAutoresizingMaskIntoConstraints = false
    }

}
