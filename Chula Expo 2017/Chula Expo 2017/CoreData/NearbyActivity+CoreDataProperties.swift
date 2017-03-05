//
//  NearbyActivity+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 3/6/2560 BE.
//
//

import Foundation
import CoreData


extension NearbyActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NearbyActivity> {
        return NSFetchRequest<NearbyActivity>(entityName: "NearbyActivity");
    }

    @NSManaged public var activityId: String?
    @NSManaged public var toActivity: ActivityData?

}
