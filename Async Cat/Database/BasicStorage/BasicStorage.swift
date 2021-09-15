//
//  BasicStorage.swift
//  Async Cat
//
//  Created by Алексей Титов on 11.09.2021.
//

import Foundation
import CoreData

protocol BasicStorage {
    associatedtype T: NSManagedObject
    var persistentContainer: NSPersistentContainer { get set }
    var context: NSManagedObjectContext { get set }
    
    func fetchRequest() -> NSFetchRequest<T>
    
    func getAllObjects(completion: @escaping ([T]?) -> ())
    func removeObject(with id: NSManagedObjectID)
}

extension BasicStorage {
    
    func fetchRequest() -> NSFetchRequest<T> {
        let className = String(describing: T.self)
        let request = NSFetchRequest<T>(entityName: className)
        request.returnsObjectsAsFaults = false
        return request
    }
    
    func getAllObjects(completion: @escaping ([T]?) -> ()) {
        let fetchRequest: NSFetchRequest<T> = fetchRequest()
        let asyncFetch = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { asyncResult in
            DispatchQueue.main.async {
                if let items = asyncResult.finalResult {
                    completion(items)
                }
            }
            
        }
        context.perform {
            do {
                try context.execute(asyncFetch)
            } catch let error {
                print(error)
            }
        }
    }
    
    func save(with context: NSManagedObjectContext) {
        context.perform {
            if context.hasChanges {
                do {
                    print("save is Main: \(Thread.isMainThread)")
                    try context.save()
                    print("успешно сохранены изменения")
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    
    func removeObject(with id: NSManagedObjectID) {
        let background = persistentContainer.newBackgroundContext()
        if let obj = try? background.existingObject(with: id) {
            background.delete(obj)
            save(with: background)
        }
    }
}
