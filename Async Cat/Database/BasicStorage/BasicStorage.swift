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
    
    func getAllObjects() -> [T]?
    func saveInBackground()
    
}
