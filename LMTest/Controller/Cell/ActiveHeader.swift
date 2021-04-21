//
//  ActiveHeader.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import UIKit

class ActiveHeader: UICollectionReusableView{
    
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
}
