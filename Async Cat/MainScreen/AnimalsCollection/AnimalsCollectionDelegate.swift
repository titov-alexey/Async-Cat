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
        dataSource.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == dataSource.count {
            let cell = collectionView.dequeueReusableCell(cell: AddAnimalCell.self, for: indexPath)
            cell.configure(with: nil)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(cell: AnimalCell.self, for: indexPath)
            cell.configure(with: dataSource[indexPath.row])
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count {
            actionDelegate?.addData()
        } else {
            let animal = dataSource[indexPath.row]
            actionDelegate?.removeAnimal(animal, index: indexPath)
        }
        
    }
}
