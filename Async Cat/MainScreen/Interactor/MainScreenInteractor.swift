//
//  MainScreenInteractor.swift
//  Async Cat
//
//  Created by R2D2 on 21.08.2021.
//

import Foundation

protocol MainScreenInteractorProtocol {
    var network: NetworkService { get }
    
    func listenCat(_ closure: @escaping (String) -> Void)
    func addCat()
    func getCats()
    func stopListenCat()
    func deleteCat(animal: AnimalDTO, index: IndexPath)
}

class MainScreenInteractor: MainScreenInteractorProtocol {
    
    
    var network: NetworkService
    
    let storage: AnimalStorageProtocol
    let presenter: MainScreenPresenterProtocol
    
    init(network: NetworkService,
         presenter: MainScreenPresenterProtocol,
         storage: AnimalStorageProtocol) {
        self.network = network
        self.presenter = presenter
        self.storage = storage
    }
    
    func listenCat(_ closure: @escaping (String) -> Void) {
        network.connect()
        network.startObserve(observer: { text in
            DispatchQueue.main.async {
                closure(text)
            }
        })
    }
    
    func stopListenCat() {
        network.disconnect()
    }
    
    func addCat() {
        let animal = AnimalDTO(
            name: "Hugo",
            type: .Cat)
        let saved = storage.saveAnimal(animal)
        presenter.addAnimal(AnimalDTO(animal: saved))
    }
        
    func getCats() {
        storage.getAnimals { [weak self] animals in
            self?.presenter.displayAnimals(animals.map(AnimalDTO.init))
        }
        
    }
    
    func deleteCat(animal: AnimalDTO, index: IndexPath) {
        storage.removeAnimal(animal)
        presenter.removeAnimal(indexPath: index)
    }
    
}

