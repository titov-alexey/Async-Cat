//
//  MainScreenView.swift
//  Async Cat
//
//  Created by Алексей Титов on 10.09.2021.
//

import Foundation
import UIKit

protocol MainScreenViewDelegate: AnyObject {
    func saveButtonDidTap()
    func showAllDidTap() 
}

class MainScreenView: UIView {
    
    let collection = AnimalsCollectionView()
    let buttontStack = UIStackView()
    let saveButton = UIButton()
    let getAllButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setupButtons()
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
        
        getAllButton.translatesAutoresizingMaskIntoConstraints = false
        getAllButton.setTitle("getAll", for: .normal)
        getAllButton.backgroundColor = .white
        getAllButton.setTitleColor(.black, for: .normal)
        
        buttontStack.addArrangedSubview(saveButton)
        buttontStack.addArrangedSubview(getAllButton)
        buttontStack.translatesAutoresizingMaskIntoConstraints = false
        buttontStack.axis = .horizontal
        buttontStack.distribution = .fillEqually
        buttontStack.alignment = .center
        buttontStack.spacing = 16
        
        addSubview(buttontStack)
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            getAllButton.heightAnchor.constraint(equalToConstant: 40),
            
            buttontStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttontStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            buttontStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
        ])
    }
    
    func updateData(dataSource: AnimalCollectionDelegate) {
        collection.dataSource = dataSource
        collection.reloadSections([0])
    }
    
    func setupDelegate(dataDelegate: AnimalCollectionDelegate) {
        collection.delegate = dataDelegate
        collection.dataSource = dataDelegate
    }

    
    func setupCollection() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(AnimalCell.self)
        collection.backgroundColor = .darkGray
        
        
        addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collection.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            collection.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: buttontStack.topAnchor),
        ])
    }
}
