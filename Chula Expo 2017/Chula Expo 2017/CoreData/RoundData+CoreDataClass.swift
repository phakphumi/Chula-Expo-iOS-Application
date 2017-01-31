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
        activityId: String,
        roundNo: Int16,
        startTime: NSDate,
        endTime: NSDate,
        reservable: Bool,
        seatAvaliable: Int16,
        reserved: Int16,
        fullCapacity: Int16,
        isReserve: Bool,
        isFavorite: Bool,
        isHighlight: Bool,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> RoundData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RoundData")
        request.predicate = NSPredicate(format: "activityId = %@ AND roundNo = %i", activityId, roundNo)
        
        if let result = (try? context.fetch(request))?.first as? RoundData
        {
            // found this event in the database, return it ...
            print("Found round \(result.roundNo) in activityId \(result.activityId)")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "RoundData", into: context) as? RoundData
            {
                // created a new event in the database
                newData.activityId = activityId
                newData.roundNo = roundNo
                newData.startTime = startTime
                newData.endTime = endTime
                newData.reservable = reservable
                newData.seatAvaliable = seatAvaliable
                newData.reserved = reserved
                newData.fullCapacity = fullCapacity
                newData.isReserve = isReserve
                newData.isFavorite = isFavorite
                newData.isHighlight = isHighlight
                return newData
            }
        }
        return nil
    }

}
