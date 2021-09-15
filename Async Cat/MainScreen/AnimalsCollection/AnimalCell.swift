//
//  AnimalCell.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import UIKit

class AnimalCell: UICollectionViewCell, ConfigurableCell {
    
    let animalImg = UIImageView()
    let animalName = UILabel()
    let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            let duration = isHighlighted ? 0.45 : 0.4
            let transform = isHighlighted ?
                CGAffineTransform(scaleX: 0.96, y: 0.96) : CGAffineTransform.identity
            let bgColor = isHighlighted ?
                UIColor(white: 1.0, alpha: 0.2) : UIColor(white: 1.0, alpha: 0.1)
            let animations = {
                self.transform = transform
                self.contentView.backgroundColor = bgColor
            }
            
            UIView.animate(withDuration: duration,
                           delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 0.0,
                           options: [.allowUserInteraction, .beginFromCurrentState],
                           animations: animations,
                           completion: nil)
        }
    }
    
    func configure(with animal: AnimalDTO) {
        animalImg.image = UIImage(named: "cat.splashscreen")!
        animalName.text = animal.name
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        contentView.layer.cornerRadius = 12
        contentView.layer.cornerCurve = .continuous
        contentView.clipsToBounds = true
        
        animalImg.translatesAutoresizingMaskIntoConstraints = false
        animalImg.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        animalName.translatesAutoresizingMaskIntoConstraints = false
        animalName.setContentHuggingPriority(.defaultHigh, for: .vertical)
        animalName.font = .systemFont(ofSize: 14, weight: .medium)
        animalName.textAlignment = .center
        animalName.numberOfLines = 1
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(animalImg)
        stack.addArrangedSubview(animalName)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        
        contentView.addSubview(stack)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animalName.text = ""
        animalImg.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -20),
            stack.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, constant: -20),
            
            animalImg.heightAnchor.constraint(equalTo: animalImg.widthAnchor),
        ])
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
//        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//        return layoutAttributes
//    }
}
