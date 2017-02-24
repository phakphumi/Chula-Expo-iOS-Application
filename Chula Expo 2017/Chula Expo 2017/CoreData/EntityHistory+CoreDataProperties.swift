//
//  EntityHistory+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 2/23/2560 BE.
//
//

import Foundation
import CoreData


extension EntityHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityHistory> {
        return NSFetchRequest<EntityHistory>(entityName: "EntityHistory");
    }

    @NSManaged public var name: String?
    @NSManaged public var dateCreated: NSDate?
    @NSManaged public var dateUpdated: NSDate?

}
