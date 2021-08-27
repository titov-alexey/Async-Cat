//
//  AnimalsDataStorage.swift
//  Async Cat
//
//  Created by R2D2 on 27.08.2021.
//

import Foundation
import CoreData

class AnimalsDataStorage {
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "Animals_data", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
}
