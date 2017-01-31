//
//  ActivityData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(ActivityData)
public class ActivityData: NSManagedObject {
    
    class func addStageEventData(
        activityId: String,
        stageNo: Int16,
        name: String,
        desc: String,
        startTime: NSDate,
        endTime: NSDate,
        isFavorite: Bool,
        reservable: Bool,
        fullCapacity: Int16,
        reserved: Int16,
        seatAvaliable: Int16,
        isReserve: Bool,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> ActivityData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(request))?.first as? ActivityData
        {
            // found this event in the database, return it ...
            print("Found \(result.name) in ActivityData")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "ActivityData", into: context) as? ActivityData
            {
                // created a new event in the database
                newData.bannerUrl = ""
                newData.desc = desc
                newData.activityId = activityId
                newData.locationDesc = ""
                newData.name = name
                newData.thumbnailsUrl = ""
                newData.isStageEvent = true
                newData.stageNo = stageNo
                newData.toImages = NSSet()
                newData.toVideos = NSSet()
                newData.toTags = NSSet()
                newData.toFaculty = NSSet()
                newData.addRound(roundNo: 1, starTime: startTime, endTime: endTime, reservable: reservable, seatAvaliable: seatAvaliable, reserved: reserved, fullCapacity: fullCapacity, isReserve: isReserve, isFavorite: isFavorite, isHighlight: false, inManageobjectcontext: context)
                return newData
            }
        }
        return nil
    }
    
    class func addEventData(
        activityId: String,
        name: String,
        desc: String,
        locationDesc: String,
        bannerUrl: String,
        thumbnailsUrl: String,
        startTime: NSDate,
        endTime: NSDate,
        isFavorite: Bool,
        isHighlight: Bool,
        reservable: Bool,
        fullCapacity: Int16,
        reserved: Int16,
        seatAvaliable: Int16,
        isReserve: Bool,
        toImages: NSSet,
        toVideos: NSSet,
        toTags: NSSet,
        toFaculty: NSSet,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> ActivityData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(request))?.first as? ActivityData
        {
            // found this event in the database, return it ...
            print("Found \(result.name) in ActivityData")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "ActivityData", into: context) as? ActivityData
            {
                // created a new event in the database
                newData.bannerUrl = bannerUrl
                newData.desc = desc
                newData.activityId = activityId
                newData.locationDesc = locationDesc
                newData.name = name
                newData.thumbnailsUrl = thumbnailsUrl
                newData.isStageEvent = false
                newData.stageNo = 0
                newData.toImages = toImages
                newData.toVideos = toVideos
                newData.toTags = toTags
                newData.toFaculty = toFaculty
                newData.addRound(roundNo: 1, starTime: startTime, endTime: endTime, reservable: reservable, seatAvaliable: seatAvaliable, reserved: reserved, fullCapacity: fullCapacity, isReserve: isReserve, isFavorite: isFavorite, isHighlight: isHighlight, inManageobjectcontext: context)
                return newData
            }
        }
        return nil
    }
    
    class func fetchActivityDetails( activityId: String, inManageobjectcontext context: NSManagedObjectContext ) -> ActivityData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "activityId = %@", activityId)
        
        do {
            let result = try context.fetch(request).first as? ActivityData
            return result
        } catch {
            print("Couldn't fetch results")
        }
        return nil
    }
    
    func addRound(
        roundNo: Int16,
        starTime: NSDate,
        endTime: NSDate,
        reservable: Bool,
        seatAvaliable: Int16,
        reserved: Int16,
        fullCapacity: Int16,
        isReserve: Bool,
        isFavorite: Bool,
        isHighlight: Bool,
        inManageobjectcontext context: NSManagedObjectContext
        ){
        
        toRound = toRound?.adding(RoundData.addData(activityId: activityId!, roundNo: roundNo, startTime: starTime, endTime: endTime, reservable: reservable, seatAvaliable: seatAvaliable, reserved: reserved, fullCapacity: fullCapacity, isReserve: isReserve, isFavorite: isFavorite, isHighlight: isHighlight, inManageobjectcontext: context)!) as NSSet?
    }
}
