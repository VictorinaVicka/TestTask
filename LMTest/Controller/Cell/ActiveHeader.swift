//
//  ActiveHeader.swift
//  LMTest
//
//  Created by Виктория Воробьева on 19.04.2021.
//

import UIKit

class ActiveHeader: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var name: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private func addConstraints() {
        addSubview(name)
        name.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        name.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
