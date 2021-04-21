//
//  ActiveChatCell.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import UIKit

class ActiveChatCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        addConstraints()
        
    }
    
    fileprivate lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    func configure(with chat: MChat) {
        imageView.image = UIImage(named: chat.image)
        priceLabel.text = chat.price
        nameLabel.text = chat.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: self.frame.width - 28)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            priceLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}
