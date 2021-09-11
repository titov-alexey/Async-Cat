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
        
        container.register(MainScreenRouter.self) { r in
            return r.resolve(ApplicationCoordinator.self)!
        }
    }
    
    func registerMainScreen() {
        
        container.register(MainScreenPresenterProtocol.self) { r in
            return MainScreenPresenter()
        }
        
        container.register(AnimalsStorage.self) { r in
            return AnimalsStorage()
        }
        
        container.register(MainScreenInteractorProtocol.self) { r in
            let network = r.resolve(NetworkService.self)!
            let presenter = r.resolve(MainScreenPresenterProtocol.self)!
            let storage = r.resolve(AnimalsStorage.self)!
            return MainScreenInteractor(network: network,
                                        presenter: presenter,
                                        storage: storage)
        }
        
        container.register(MainScreen.self) { r in
            let intaractor = r.resolve(MainScreenInteractorProtocol.self)
            return MainScreenController(interactor: intaractor!)
        }.initCompleted { r, controller in
            let mainScreenController = controller as! MainScreenController
            var presenter = r.resolve(MainScreenPresenterProtocol.self)
            presenter?.viewController = mainScreenController
            mainScreenController.output = r.resolve(MainScreenRouter.self)
        }
    }
}
