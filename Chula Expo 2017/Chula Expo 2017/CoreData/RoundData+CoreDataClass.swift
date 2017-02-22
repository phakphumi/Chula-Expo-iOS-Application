//
//  RoundData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(RoundData)
public class RoundData: NSManagedObject {
    
    class func addData(
        id: String,
        activityId: String,
        startTime: Date,
        endTime: Date,
        seatAvaliable: Int16,
        reserved: Int16,
        fullCapacity: Int16,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> RoundData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RoundData")
        request.predicate = NSPredicate(format: "activityId = %@", activityId)
        
        if let result = (try? context.fetch(request))?.first as? RoundData
        {
            // found this event in the database, return it ...
            print("Found round \(result.id ?? "") in activityId \(result.activityId ?? "")")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "RoundData", into: context) as? RoundData
            {
                // created a new event in the database
                newData.id = id
                newData.activityId = activityId
                newData.startTime = startTime
                newData.endTime = endTime
                newData.seatAvaliable = seatAvaliable
                newData.reserved = reserved
                newData.fullCapacity = fullCapacity
                return newData
            }
        }
        return nil
    }

}
