//
//  ActiveSectionsCell.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import UIKit

class ActiveCatalogCell: UICollectionViewCell {
    static var reuseId: String = "ActiveCatalogCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9481367469, green: 0.9530696273, blue: 0.9615190625, alpha: 1)
        layer.cornerRadius = 4.0
        clipsToBounds = true
        addConstraints()
        
    }
    
    var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
//        imageView.image = UIImage(named: "8")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func configure(with chat: MChat) {
        imageView.image = UIImage(named: chat.image)
        nameLabel.text = chat.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

    }
}
