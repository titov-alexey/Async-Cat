//
//  AnimalsStorage.swift
//  Async Cat
//
//  Created by R2D2 on 28.08.2021.
//

import Foundation
import CoreData

protocol BasicStorage {
    associatedtype T 
    var persistentContainer: NSPersistentContainer { get set }
    var context: NSManagedObjectContext { get set }
    
    func getAllObjects() -> [T]?
    func saveInBackground()
    
}

class AnimalsStorage: BasicStorage {

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
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        context = persistentContainer.viewContext
    }
    
    
    func getAllObjects() -> [Animal]? {
        let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        let objects = try? context.fetch(fetchRequest)
        return objects
    }
    
    func saveInBackground() {
        let context = persistentContainer.newBackgroundContext()
        context.perform { [weak self] in
            if self?.context.hasChanges != nil {
                do {
                    try self?.context.save()
                } catch {
                    self?.context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
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
