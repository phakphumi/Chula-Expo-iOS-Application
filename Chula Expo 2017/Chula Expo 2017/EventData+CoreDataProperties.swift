//
//  EventData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData


extension EventData
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventData>
    {
        return NSFetchRequest<EventData>(entityName: "EventData");
    }

    @NSManaged public var name: String?
    @NSManaged public var tumbnail: String?
    @NSManaged public var startTime: NSDate?
    @NSManaged public var endTime: NSDate?
    @NSManaged public var longDesc: String?
    @NSManaged public var shortDesc: String?
    @NSManaged public var facity: String?
    @NSManaged public var locationDesc: String?
    @NSManaged public var canReserve: Bool
    @NSManaged public var isReserve: Bool
    @NSManaged public var isFavorite: Bool
    @NSManaged public var numOfSeat: Int16
    
    var dateSection: String
    {
        get
        {
            if self.startTime!.isToday()
            {
                return "TODAY"
            }
            else if self.startTime!.isTomorrow()
            {
                return "TOMORROW"
            }
            else if self.startTime!.isYesterday()
            {
                return "YESTERDAY"
            }
            else
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, EEE H m"
                return dateFormatter.string(from: startTime! as Date)
            }
        }
    }
}
