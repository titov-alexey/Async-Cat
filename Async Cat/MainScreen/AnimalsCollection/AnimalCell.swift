//
//  AnimalCell.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import UIKit

class AnimalCell: UICollectionViewCell, AnimalLogic {
    
    let animalImg = UIImageView(image: UIImage(named: "cat.splashscreen")!)
    let animalName = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with img: UIImage) {
        animalImg.image = img
        animalName.text = "Aboba"
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        
        animalName.font = .systemFont(ofSize: 14, weight: .medium)
        
        contentView.addSubview(animalImg)
        contentView.addSubview(animalName)
    }
    
    private func setupConstraints() {
        
    }
}
