//
//  ActiveQRCode.swift
//  LMTest
//
//  Created by Виктория Воробьева on 20.04.2021.
//

import UIKit

class QRCodeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        tintColor = .black
        layer.cornerRadius = 3
        clipsToBounds = true
        setImage(UIImage(systemName: "qrcode"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
