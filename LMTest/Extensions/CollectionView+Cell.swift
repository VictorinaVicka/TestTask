//
//  CollectionView+Cell.swift
//  LMTest
//
//  Created by Виктория Воробьева on 20.04.2021.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellWithClass type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: type))
    }
    
    func register<T: UICollectionReusableView>(viewWithClass type: T.Type, kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
    }
    
    func dequeue<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: type))")
        }
        return cell
    }
    
    func dequeue<T: UICollectionReusableView>(_ type: T.Type, kind: String, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: String(describing: type),
                for: indexPath
        ) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: type))")
        }
        
        return view
    }
    
}
