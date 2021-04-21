//
//  ActiveSectionsCell.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import UIKit

class ActiveCatalogCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 4.0
        clipsToBounds = true
        addConstraints()
    }
    
    fileprivate lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    fileprivate lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.dash")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var view: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    func configure(with chat: MChat) {
        if chat.name == "Каталог" {
            backgroundColor = .systemGreen
            nameLabel.textColor = .white
            imageView.image = UIImage(systemName: "list.dash")
            imageView.tintColor = .white
        } else {
            backgroundColor = #colorLiteral(red: 0.9481367469, green: 0.9530696273, blue: 0.9615190625, alpha: 1)
            imageView.image = UIImage(named: chat.image)
        }
        nameLabel.text = chat.name
    }
    
    private func addConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(nameLabel)
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
