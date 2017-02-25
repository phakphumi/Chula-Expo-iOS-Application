//
//  FavoritedActivity+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 2/13/2560 BE.
//
//

import Foundation
import CoreData


extension FavoritedActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedActivity> {
        return NSFetchRequest<FavoritedActivity>(entityName: "FavoritedActivity");
    }

    @NSManaged public var activityId: String?
    @NSManaged public var toActivity: ActivityData?

}
