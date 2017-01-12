//
//  StageEvent+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData


extension StageEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StageEvent> {
        return NSFetchRequest<StageEvent>(entityName: "StageEvent");
    }

    @NSManaged public var name: String?
    @NSManaged public var canReserve: Bool
    @NSManaged public var startTime: NSDate?
    @NSManaged public var endTime: NSDate?
    @NSManaged public var desc: String?
    @NSManaged public var numOfSeat: Int16
    @NSManaged public var stage: Int16
}
