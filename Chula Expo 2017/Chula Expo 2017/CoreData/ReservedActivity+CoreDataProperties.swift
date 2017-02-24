//
//  ReservedActivity+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 2/23/2560 BE.
//
//

import Foundation
import CoreData


extension ReservedActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReservedActivity> {
        return NSFetchRequest<ReservedActivity>(entityName: "ReservedActivity");
    }

    @NSManaged public var activityId: String?
    @NSManaged public var toActivity: ActivityData?

}
