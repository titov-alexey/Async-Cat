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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animal> {
        return NSFetchRequest<Animal>(entityName: "Animal")
    }


}

extension Animal : Identifiable {

}
