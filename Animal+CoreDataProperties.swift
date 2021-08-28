//
//  Animal+CoreDataProperties.swift
//  Async Cat
//
//  Created by R2D2 on 27.08.2021.
//
//

import Foundation
import CoreData


extension Animal {

    @NSManaged public var name: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var type: String?
    @NSManaged public var uuid: UUID?

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animal> {
        return NSFetchRequest<Animal>(entityName: "Animal")
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        dateCreated = Date()
        uuid = UUID()
    }
}

extension Animal : Identifiable {

}
