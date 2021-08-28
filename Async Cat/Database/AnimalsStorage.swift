//
//  AnimalsStorage.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import CoreData

class AnimalsStorage {
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Animals_datamodel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Не удалось создать БД")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistantContainer.newBackgroundContext()
    }
    
    func getAllObjects() -> [Animal]? {
        let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        let objects = try? context.fetch(fetchRequest)
        print(objects ?? [])
        return objects
    }
    
    
    func saveContext() {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
}
