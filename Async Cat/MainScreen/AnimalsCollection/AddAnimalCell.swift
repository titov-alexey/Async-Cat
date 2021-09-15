//
//  AddAnimalCell.swift
//  Async Cat
//
//  Created by Алексей Титов on 15.09.2021.
//

import Foundation
import UIKit

class AddAnimalCell: UICollectionViewCell, ConfigurableCell {
    
    let imageView = UIImageView(image: UIImage(systemName: "plus"))
    func configure(with: UIImage?) {
        contentView.backgroundColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 0.201870368)
        contentView.layer.cornerRadius = 15
    }
    
}
