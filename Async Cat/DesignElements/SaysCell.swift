//
//  SaysCell.swift
//  Async Cat
//
//  Created by R2D2 on 21.08.2021.
//

import Foundation
import UIKit

class SaysCell: UIView {
    
    let label = UILabel()
    init(text: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.leftAnchor.constraint(equalTo: label.leftAnchor, constant: -10),
            self.rightAnchor.constraint(equalTo: label.rightAnchor, constant: 10),
            self.topAnchor.constraint(equalTo: label.topAnchor, constant: -10),
            self.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 10)
        ])
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
