//
//  AnimalLogic.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation

protocol AnimalLogic {
    associatedtype T
    
    func configure(with: T)
    
}
