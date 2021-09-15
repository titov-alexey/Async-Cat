//
//  Animal+CoreDataClass.swift
//  Async Cat
//
//  Created by Алексей Титов on 31.08.2021.
//
//

import Foundation
import CoreData

@objc(Animal)
public class Animal: NSManagedObject {

    deinit {
        print("animal deinit")
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        dateCreated = Date()
        uuid = UUID()
    }
}
