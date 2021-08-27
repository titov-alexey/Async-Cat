//
//  MainScreen.swift
//  Async Cat
//
//  Created by R2D2 on 21.08.2021.
//

import Foundation
import UIKit

protocol MainScreen: UIViewController {
    var interactor: MainScreenInteractorProtocol { get }
  
}

class MainScreenController: UIViewController, MainScreen {
    var interactor: MainScreenInteractorProtocol
    weak var output: MainScreenOutput?
    
    let cat = UIImageView(image: UIImage(named: "cat.splashscreen"))
    
    init(interactor: MainScreenInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setupCat()

        interactor.listenCat { [weak self] catSay in
            DispatchQueue.main.async {
                self?.showCatWords(catSay)
            }
            
        }
        
    }
    
    func showCatWords(_ word: String) {
        let cell = SaysCell(text: word)
        cell.isHidden = true
        view.addSubview(cell)
        cell.centerXAnchor.constraint(equalTo: cat.centerXAnchor, constant: 50).isActive = true
        cell.centerYAnchor.constraint(equalTo: cat.centerYAnchor, constant: -100).isActive = true
        UIView.animate(withDuration: 1.5) {
            cell.isHidden = false
            cell.frame.origin.y = cell.frame.origin.y - 70
            cell.alpha = 0
        } completion: { _ in
            cell.isHidden = true
            cell.removeFromSuperview()
        }

    }
    
    
    func setupCat() {
        
        cat.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cat)
        
        NSLayoutConstraint.activate([
            cat.heightAnchor.constraint(equalToConstant: 120),
            cat.widthAnchor.constraint(equalToConstant: 120),
            cat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cat.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
}
