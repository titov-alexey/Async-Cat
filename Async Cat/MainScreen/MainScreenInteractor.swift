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
    func getAllCats()
    func stopListenCat()
}

class MainScreenInteractor: MainScreenInteractorProtocol {
    var network: NetworkService
    
    var storage = AnimalsStorage()
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func listenCat(_ closure: @escaping (String) -> Void) {
        network.connect()
        network.startObserve(observer: { text in
            DispatchQueue.main.async {
                closure(text)
            }
        })
    }
    
    func addCat() {
        let animal = Animal(context: storage.context)
        animal.name = "Hinata"
        animal.type = "Cat"
        
        storage.saveContext()
    }
    
    func getAllCats() {
        let objects = storage.getAllObjects()
        print(objects)
    }
    
    func stopListenCat() {
        network.disconnect()
    }
    
}
