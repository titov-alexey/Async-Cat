//
//  ApplicationCoordinator.swift
//  Async Cat
//
//  Created by R2D2 on 17.08.2021.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator{
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let mainScreen: MainScreen
    
    init(_ navigationController: UINavigationController,
         mainScreen: MainScreen) {
        self.mainScreen = mainScreen
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(mainScreen, animated: true)
    }
    
}

extension ApplicationCoordinator: MainScreenRouter {

    
}
