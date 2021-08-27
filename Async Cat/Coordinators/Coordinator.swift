//
//  Coordinator.swift
//  Async Cat
//
//  Created by R2D2 on 17.08.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}
