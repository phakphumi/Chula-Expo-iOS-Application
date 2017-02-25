//
//  StageActivity+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 2/24/2560 BE.
//
//

import Foundation
import CoreData


extension StageActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StageActivity> {
        return NSFetchRequest<StageActivity>(entityName: "StageActivity");
    }

    @NSManaged public var activityId: String?
    @NSManaged public var stage: Int16
    @NSManaged public var toActivity: ActivityData?

}
