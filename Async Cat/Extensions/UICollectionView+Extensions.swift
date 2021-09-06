//
//  UICollectionView+Extensions.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(_ cell: UICollectionViewCell.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.description())
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cell.description(), for: indexPath) as! T
    }
}
