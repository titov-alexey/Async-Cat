//
//  AnimalsCollectionDelegate.swift
//  Async Cat
//
//  Created by Алексей Титов on 01.09.2021.
//

import Foundation
import UIKit

class AnimalCollectionDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var dataSource: [AnimalDTO] = []
    weak var actionDelegate: MainScreenController?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cell: AnimalCell.self, for: indexPath)
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animal = dataSource[indexPath.row]
        actionDelegate?.removeAnimal(animal, index: indexPath)
    }
}
