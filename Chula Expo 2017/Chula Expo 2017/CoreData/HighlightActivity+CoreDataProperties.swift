//
//  HighlightActivity+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 2/24/2560 BE.
//
//

import Foundation
import CoreData


extension HighlightActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighlightActivity> {
        return NSFetchRequest<HighlightActivity>(entityName: "HighlightActivity");
    }

    @NSManaged public var activityId: String?
    @NSManaged public var toActivity: ActivityData?

}
