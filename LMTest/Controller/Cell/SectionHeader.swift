//
//  SectionHeader.swift
//  LMTest
//
//  Created by Виктория Воробьева on 20.04.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
//    static let kind = "header"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerName: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private func setupConstraints() {
        headerName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerName)
        
        NSLayoutConstraint.activate([
            headerName.topAnchor.constraint(equalTo: self.topAnchor),
            headerName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            headerName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerName.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(text: String, font: UIFont?, textColor: UIColor) {
        headerName.text = text
        headerName.textColor = textColor
        headerName.font = font
    }
}
