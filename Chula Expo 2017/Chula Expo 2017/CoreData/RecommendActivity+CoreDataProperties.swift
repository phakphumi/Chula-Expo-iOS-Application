//
//  RecommendActivity+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 2/24/2560 BE.
//
//

import Foundation
import CoreData


extension RecommendActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecommendActivity> {
        return NSFetchRequest<RecommendActivity>(entityName: "RecommendActivity");
    }

    @NSManaged public var activityId: String?
    @NSManaged public var toActivity: ActivityData?

}
