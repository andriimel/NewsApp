//
//  NewsAppCell.swift
//  NewsApp
//
//  Created by Andrii Melnyk on 1/26/24.
//

import UIKit

protocol NewsAppCellDelegate {
    func didTapLikeButton(on cell: NewsAppCell)
}
class NewsAppCell: UITableViewCell {

    static let cellIdentifier = "NewsAppCell"
    
    let avatarImage = NAAvatarImageView(frame: .zero)
    let newsSourceLabel = NASourceLabel()
    let newsLabel = NANewsLabel()
    let likeButton = NALikeButton(frame:.zero)
    
     var delegate: NewsAppCellDelegate?
    
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
    @objc private func likeButtonTapped() {
          delegate?.didTapLikeButton(on: self)
      }

    func configure() {
        
        addSubview(avatarImage)
        addSubview(newsSourceLabel)
        addSubview(newsLabel)
        contentView.addSubview(likeButton)
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)

        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            
//            
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
//
            
            newsSourceLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            newsSourceLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding),
            newsSourceLabel.trailingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: -padding),
            newsSourceLabel.heightAnchor.constraint(equalToConstant: 15),
            
            newsLabel.topAnchor.constraint(equalTo: newsSourceLabel.bottomAnchor),
            newsLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding),
            newsLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor),
            newsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)

        ])
    }

 
 }


