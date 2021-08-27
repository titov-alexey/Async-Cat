//
//  DIResolver.swift
//  Async Cat
//
//  Created by R2D2 on 21.08.2021.
//

import Foundation
import Swinject

protocol DIResolverProtocol {
    var container: Container { get }
    var navigationController: UINavigationController { get set }
    func registerDependencies()
}

class DIResolver: DIResolverProtocol {
    var navigationController: UINavigationController
    var container = Container()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func registerDependencies() {
        registerMainScreen()
        registerApplicationCoordinator()
        registerLocalNetwork()
        
        
    }
    
}

private extension DIResolver {
    
    func registerLocalNetwork() {
        container.register(NetworkService.self) { _ in
            return LocalNetworkService()
        }
        
    }
    
    func registerApplicationCoordinator() {
        container.register(ApplicationCoordinator.self) { [unowned self] r in
            let mainScreen = r.resolve(MainScreen.self)!
            return ApplicationCoordinator(navigationController,
                                          mainScreen: mainScreen)
        }.inObjectScope(.container)
        
        container.register(MainScreenOutput.self) { r in
            return r.resolve(ApplicationCoordinator.self)!
        }
    }
    
    func registerMainScreen() {
        
        container.register(MainScreenInteractorProtocol.self) { r in
            let network = r.resolve(NetworkService.self)!
            return MainScreenInteractor(network: network)
        }
        
        container.register(MainScreen.self) { r in
            let intaractor = r.resolve(MainScreenInteractorProtocol.self)
            return MainScreenController(interactor: intaractor!)
        }.initCompleted { r, controller in
            let mainScreenController = controller as! MainScreenController
            mainScreenController.output = r.resolve(MainScreenOutput.self)
        }
    }
}
