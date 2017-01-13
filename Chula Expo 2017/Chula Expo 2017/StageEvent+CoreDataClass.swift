//
//  StageEvent+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(StageEvent)
public class StageEvent: NSManagedObject {
   
    class func addData(
        name: String,
        startTime: NSDate,
        endTime: NSDate,
        desc: String,
        canReserve: Bool,
        numOfSeat: Int16,
        stage: Int16,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> StageEvent?
    {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StageEvent")
//        request.predicate = NSPredicate(format: "stage = %@ AND name = %@", stage, name)
//        
//        if let result = (try? context.fetch(request))?.first as? StageEvent
//        {
//            // found this event in the database, return it ...
//            print("Found stage event \(result.name)")
//            return result
//            
//        }
//        else 
        if let newData = NSEntityDescription.insertNewObject(forEntityName: "StageEvent", into: context) as? StageEvent
        {
            // created a new event in the database
            newData.name = name
            newData.stage = stage
            newData.desc = desc
            newData.startTime = startTime
            newData.endTime = endTime
            newData.canReserve = canReserve
            newData.numOfSeat = numOfSeat
            return newData
        }
        return nil
    }
}
