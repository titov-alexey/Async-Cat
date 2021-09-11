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
    func displayAnimals(_ animals: [Animal])
  
}

class MainScreenController: UIViewController, MainScreen {
    
    var interactor: MainScreenInteractorProtocol
    weak var output: MainScreenRouter?
    
    lazy var customView = self.view as? MainScreenView

    let collectionDelegate = AnimalCollectionDelegate()
    
    init(interactor: MainScreenInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let myVIew = MainScreenView()
        view = myVIew
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsActions()
    }
    
    
    

    
    func displayAnimals(_ animals: [Animal]) {
        collectionDelegate.dataSource = animals
        collectionDelegate.actionDelegate = self
        customView?.updateData(dataSource: collectionDelegate)
    }
    
    func removeAnimal(_ animal: Animal) {
        interactor.deleteCat(animal: animal)
    }
    
//    func showCatWords(_ word: String) {
//        let cell = SaysCell(text: word)
//        cell.isHidden = true
//        view.addSubview(cell)
//        cell.centerXAnchor.constraint(equalTo: cat.centerXAnchor, constant: 50).isActive = true
//        cell.centerYAnchor.constraint(equalTo: cat.centerYAnchor, constant: -100).isActive = true
//        UIView.animate(withDuration: 1.5) {
//            cell.isHidden = false
//            cell.frame.origin.y = cell.frame.origin.y - 70
//            cell.alpha = 0
//        } completion: { _ in
//            cell.isHidden = true
//            cell.removeFromSuperview()
//        }
//
//    }
    
    private func setButtonsActions() {
        customView?.saveButton.addTarget(self, action: #selector(addData), for: .touchUpInside)
        customView?.getAllButton.addTarget(self, action: #selector(getCats), for: .touchUpInside)
    }
    
    @objc func addData() {
        interactor.addCat()
    }
    
    @objc func getCats() {
        interactor.getCats()

    }
}
