//
//  BANewsButton.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 3/30/24.
//

import UIKit

class BANewsButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (withTitle buttonTitle: String, buttonTag: Int) {
        super.init(frame: .zero)
        self.setTitle(buttonTitle, for: .normal)
        self.tag = buttonTag
        configure()
    }
    func configure() {
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.lightGray
        translatesAutoresizingMaskIntoConstraints = false
      
    }
}
