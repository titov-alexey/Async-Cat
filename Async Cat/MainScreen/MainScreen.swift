//
//  MainScreen.swift
//  Async Cat
//
//  Created by R2D2 on 21.08.2021.
//

import Foundation
import UIKit

protocol MainScreen: UIViewController {
    var interactor: MainScreenInteractorProtocol { get }
  
}

class MainScreenController: UIViewController, MainScreen {
    
    var interactor: MainScreenInteractorProtocol
    weak var output: MainScreenOutput?
    
    let buttontStack = UIStackView()
    let collection = AnimalsCollectionView()
    let collectionDelegate = AnimalCollectionDelegate()
    
    let cat = UIImageView(image: UIImage(named: "cat.splashscreen"))
    
    init(interactor: MainScreenInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//        setupCat()
        setupButtons()
        setupCollection()

//        interactor.listenCat { [weak self] catSay in
//            self?.showCatWords(catSay)
//        }
        
    }
    
    
    @objc func addData() {
        interactor.addCat()
    }
    
    @objc func getCats() {
        collectionDelegate.dataSource = interactor.getAllCats()
        collection.reloadData()
    }
    
    func showCatWords(_ word: String) {
        let cell = SaysCell(text: word)
        cell.isHidden = true
        view.addSubview(cell)
        cell.centerXAnchor.constraint(equalTo: cat.centerXAnchor, constant: 50).isActive = true
        cell.centerYAnchor.constraint(equalTo: cat.centerYAnchor, constant: -100).isActive = true
        UIView.animate(withDuration: 1.5) {
            cell.isHidden = false
            cell.frame.origin.y = cell.frame.origin.y - 70
            cell.alpha = 0
        } completion: { _ in
            cell.isHidden = true
            cell.removeFromSuperview()
        }

    }
    
    func setupCollection() {
        collection.dataSource = collectionDelegate
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(AnimalCell.self)
        collection.backgroundColor = .clear
        
        
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: buttontStack.topAnchor),
        ])
    }
    
    
    func setupCat() {
        
        cat.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cat)
        
        NSLayoutConstraint.activate([
            cat.heightAnchor.constraint(equalToConstant: 120),
            cat.widthAnchor.constraint(equalToConstant: 120),
            cat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cat.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupButtons() {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(addData), for: .touchUpInside)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
        
        let getAllButton = UIButton()
        getAllButton.translatesAutoresizingMaskIntoConstraints = false
        getAllButton.addTarget(self, action: #selector(getCats), for: .touchUpInside)
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
        
        view.addSubview(buttontStack)
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            getAllButton.heightAnchor.constraint(equalToConstant: 40),
            
            buttontStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttontStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            buttontStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
        ])
        
    }
}
