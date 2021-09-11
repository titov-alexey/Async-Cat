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
    func deleteCat(animal: Animal)
}

class MainScreenInteractor: MainScreenInteractorProtocol {
    
    
    var network: NetworkService
    
    let storage: AnimalsStorage
    let presenter: MainScreenPresenterProtocol
    
    init(network: NetworkService,
         presenter: MainScreenPresenterProtocol,
         storage: AnimalsStorage) {
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
        let animal = Animal(context: storage.context)
        animal.name = "Hinata"
        animal.type = "Cat"
        
        storage.saveInBackground()
    }
    
    private func getAllCats() -> [Animal] {
        if let objects = storage.getAllObjects() {
            return objects
        }
        return []
    }
        
    func getCats() {
        presenter.displayAnimals(getAllCats())
    }
    
    func deleteCat(animal: Animal) {
        storage.context.delete(animal)
        storage.saveContext()
        presenter.displayAnimals(getAllCats())
    }
    
}

