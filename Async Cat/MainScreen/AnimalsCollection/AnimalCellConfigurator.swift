//
//  AnimalCellConfigurator.swift
//  Async Cat
//
//  Created by Алексей Титов on 06.09.2021.
//

import Foundation
import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(with: DataType)
    
}

protocol CellConfigurator {
    associatedtype T = ConfigurableCell
    func configure(cell: T)
}

class AnimalCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType {
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: CellType) {
        cell.configure(with: item)
    }
}
