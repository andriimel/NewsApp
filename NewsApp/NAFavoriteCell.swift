//
//  NAFavoriteCell.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 4/9/24.
//

import UIKit

protocol FavoriteCellDelegate {
    func share(on cell: NAFavoriteCell)
}
class NAFavoriteCell: UITableViewCell {


        static let cellIdentifier = "FavoriteCell"
        
        let avatarImage = NAAvatarImageView(frame: .zero)
        let newsSourceLabel = NASourceLabel()
        let newsLabel = NANewsLabel()
    var shareButton = NAShareButton()
    
        var delegate: FavoriteCellDelegate?
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: NewsAppCell.cellIdentifier)
            configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func set(article:Article) {
            
            newsSourceLabel.text = article.source.name
            newsLabel.text = article.title
            
            NetworkNewsManager.shared.downloadImage(from: article.urlToImage) { [weak self ] image  in
                guard let self = self else {return}
                DispatchQueue.main.async {self.avatarImage.image = image }
            }
        }
    
    @objc func shareNews() {
        delegate?.share(on: self)
    }
    
 
        func configure() {
            
            addSubview(avatarImage)
            addSubview(newsSourceLabel)
            addSubview(newsLabel)
                contentView.addSubview(shareButton)
            
            
            newsSourceLabel.backgroundColor = .red
            newsLabel.backgroundColor = .blue
            shareButton.addTarget(self, action: #selector(shareNews), for: .touchUpInside)
                    
            let padding: CGFloat = 10
            
            NSLayoutConstraint.activate([
                avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
                avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                avatarImage.heightAnchor.constraint(equalToConstant: 60),
                avatarImage.widthAnchor.constraint(equalToConstant: 60),
                
                
                shareButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                shareButton.heightAnchor.constraint(equalToConstant: 30),
                shareButton.widthAnchor.constraint(equalToConstant: 30),
                
                
                newsSourceLabel.topAnchor.constraint(equalTo: topAnchor),
                newsSourceLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding),
                newsSourceLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -padding),
                newsSourceLabel.heightAnchor.constraint(equalToConstant: 15),
                
                newsLabel.topAnchor.constraint(equalTo: newsSourceLabel.bottomAnchor),
                newsLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding),
                newsLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor,constant: -padding),
                newsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)

            ])
        }

     
     }


