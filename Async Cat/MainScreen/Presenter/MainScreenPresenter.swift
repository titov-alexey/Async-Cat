//
//  MainScreenPresenter.swift
//  Async Cat
//
//  Created by Алексей Титов on 10.09.2021.
//

import Foundation

protocol MainScreenPresenterProtocol {
    var viewController: MainScreen? { get set }
    func displayAnimals(_ animals: [AnimalDTO])
    func addAnimal(_ animal: AnimalDTO)
    func removeAnimal(indexPath: IndexPath)
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    weak var viewController: MainScreen?
    
    func displayAnimals(_ animals: [AnimalDTO]) {
        viewController?.displayAnimals(animals)
    }
    
    func removeAnimal(indexPath: IndexPath) {
        viewController?.deleteAnimalFromCollection(at: indexPath)
    }
    
    func addAnimal(_ animal: AnimalDTO) {
        viewController?.addAnimal(animal)
    }
}
