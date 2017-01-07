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
    
    class func addData(withName name: String, facityIs facity: String, inManageobjectcontext context: NSManagedObjectContext) -> EventData?
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventData")
        request.predicate = NSPredicate(format: "facity = %@ AND name = %@", facity, name)
        
        if let result = (try? context.fetch(request))?.first as? EventData
        {
            // found this tweet in the database, return it ...
            result.name = name
            result.facity = facity
            result.startTime = NSDate(timeIntervalSinceNow: 86400)
            print("Found \(result.name) AND updated")
            
            return result
            
        } else if let newData = NSEntityDescription.insertNewObject(forEntityName: "EventData", into: context) as? EventData
        {
            // created a new tweet in the database
            // load it up with information from the Twitter.Tweet ...
            newData.name = name
            newData.facity = facity
            newData.startTime = NSDate(timeIntervalSinceNow: 86400)
            
            return newData
        }
        return nil
    }
}
