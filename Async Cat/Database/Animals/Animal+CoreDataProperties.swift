//
//  Animal+CoreDataProperties.swift
//  Async Cat
//
//  Created by Алексей Титов on 31.08.2021.
//
//

import Foundation
import CoreData


extension Animal {

    @NSManaged public var dateCreated: Date?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var uuid: UUID?

}

extension Animal : Identifiable {

}
