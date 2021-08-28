//
//  AnimalsCollectionView.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import UIKit

class AnimalsCollectionView: UICollectionView {
    
    let collectionLayout = UICollectionViewFlowLayout()
    
    init() {
        collectionLayout.itemSize = CGSize(width: 140, height: 140)
        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionLayout.minimumLineSpacing = 10
        collectionLayout.minimumInteritemSpacing = 10
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
