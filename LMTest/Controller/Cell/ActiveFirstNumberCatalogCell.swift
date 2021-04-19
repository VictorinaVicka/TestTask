//
//  ActiveFirstNumberCatalogCell.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import UIKit

class ActiveFirstNumberCatalogCell: UICollectionViewCell {
    static var reuseId: String = "ActiveFirstNumberCatalogCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.4317904115, green: 0.8198150992, blue: 0.3567215204, alpha: 1)
        layer.cornerRadius = 4.0
        clipsToBounds = true
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    func configure(with chat: MChat) {
        imageView.image = UIImage(named: chat.image)
        nameLabel.text = chat.name
    }
    
    private func addConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
