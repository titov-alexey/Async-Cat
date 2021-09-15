//
//  AnimalDTO.swift
//  Async Cat
//
//  Created by Алексей Титов on 13.09.2021.
//

import Foundation
import CoreData

struct AnimalDTO {
    
    enum AnimalType: String {
        case Cat
        case Dog
        case Cow
    }
    
    var name: String
    var type: AnimalType?
    var dateCreated: Date?
    var uuid: UUID?
    var storageID: NSManagedObjectID?
    
    init(name: String, type: AnimalType) {
        self.name = name
        self.type = type
    }
    
    init(animal: Animal) {
        name = animal.name!
        type = AnimalType(rawValue: animal.type ?? "")
        dateCreated = animal.dateCreated!
        uuid = animal.uuid!
        storageID = animal.objectID
    }
    
}
