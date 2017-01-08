//
//  EventData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(EventData)
public class EventData: NSManagedObject
{
    
    class func addData(
        name: String,
        facity: String,
        locationDesc: String,
        startTime: NSDate,
        endTime: NSDate,
        shortDesc: String,
        longDesc: String,
        canReserve: Bool,
        numOfSeat: Int16,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> EventData?
   
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventData")
        request.predicate = NSPredicate(format: "facity = %@ AND name = %@", facity, name)
        
        if let result = (try? context.fetch(request))?.first as? EventData
        {
            // found this event in the database, return it ...
            print("Found \(result.name)")
            return result
            
        }
        else if let newData = NSEntityDescription.insertNewObject(forEntityName: "EventData", into: context) as? EventData
        {
            // created a new event in the database
            newData.name = name
            newData.facity = facity
            newData.locationDesc = locationDesc
            newData.startTime = startTime
            newData.endTime = endTime
            newData.shortDesc = shortDesc
            newData.longDesc = longDesc
            newData.canReserve = canReserve
            newData.numOfSeat = numOfSeat
            return newData
        }
        return nil
    }
}
