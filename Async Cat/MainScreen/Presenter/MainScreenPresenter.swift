//
//  MainScreenPresenter.swift
//  Async Cat
//
//  Created by Алексей Титов on 10.09.2021.
//

import Foundation

protocol MainScreenPresenterProtocol {
    var viewController: MainScreen? { get set }
    func displayAnimals(_ animals: [Animal])
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    weak var viewController: MainScreen?
    
    func displayAnimals(_ animals: [Animal]) {
        viewController?.displayAnimals(animals)
    }
}
