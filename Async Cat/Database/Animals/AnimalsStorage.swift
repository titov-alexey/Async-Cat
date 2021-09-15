//
//  AnimalsStorage.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import CoreData

protocol AnimalStorageProtocol {
    func getAnimals(_ completion: @escaping ([Animal]) -> ())
    func removeAnimal(_ animal: AnimalDTO)
    func saveAnimal(_ animal: AnimalDTO) -> Animal
}

final class AnimalsStorage: BasicStorage {
    typealias T = Animal
    var persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Animals_datamodel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Не удалось создать контейнер для БД: \(error.localizedDescription)")
            }
        }
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
    }
    
}

extension AnimalsStorage: AnimalStorageProtocol {
    func saveAnimal(_ animal: AnimalDTO) -> Animal {
        let backGroundContext = persistentContainer.newBackgroundContext()
        let a = Animal(context: backGroundContext)
        a.name = animal.name
        a.type = animal.type!.rawValue
        save(with: backGroundContext)
        return a
    }
    
    func getAnimals(_ completion: @escaping ([Animal]) -> ()) {
        getAllObjects(completion: { animals in
            completion(animals ?? [])
        })
    }
    
    func removeAnimal(_ animal: AnimalDTO) {
        if let id = animal.storageID {
            removeObject(with: id)
        }
    }
}
