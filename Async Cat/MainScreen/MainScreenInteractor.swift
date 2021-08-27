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
    func stopListenCat()
}

class MainScreenInteractor: MainScreenInteractorProtocol {
    var network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func listenCat(_ closure: @escaping (String) -> Void) {
        network.connect()
        network.startObserve(observer: closure)
    }
    
    func stopListenCat() {
        network.disconnect()
    }
    
}
