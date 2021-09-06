//
//  AnimalsCollectionView.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import UIKit

class AnimalsCollectionView: UICollectionView {
    
    let collectionLayout = AnimalFlowLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        register(AnimalCell.self)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnimalsCollectionView: UICollectionViewDelegate {
    
}
