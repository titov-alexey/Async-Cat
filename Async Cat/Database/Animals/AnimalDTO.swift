//
//  AnimalDTO.swift
//  Async Cat
//
//  Created by Алексей Титов on 13.09.2021.
//

import Foundation

struct AnimalDTO {
    
    enum AnimalType: String {
        case Cat
        case Dog
        case Cow
    }
    
    var name: String
    var type: AnimalType
//    var dateCreated: Date
    
//    mutating func from(_ animal: Animal) {
//        name = animal.name
//        type = AnimalType(rawValue: animal.type ?? "")
//        dateCreated = animal.dateCreated
//
//    }
    
}
