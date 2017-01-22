//
//  ActivityData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/20/2560 BE.
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
                newData.endTime = endTime
                newData.activityId = activityId
                newData.isFavorite = isFavorite
                newData.isReserve = isReserve
                newData.isHighlight = false
                newData.locationDesc = ""
                newData.name = name
                newData.reservable = reservable
                newData.startTime = startTime
                newData.thumbnailsUrl = ""
                newData.isStageEvent = true
                newData.stageNo = stageNo
                newData.toImages = NSSet()
                newData.toVideos = NSSet()
                newData.toTags = NSSet()
                newData.toFaculty = NSSet()
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
                newData.endTime = endTime
                newData.activityId = activityId
                newData.isFavorite = isFavorite
                newData.isReserve = isReserve
                newData.isHighlight = isHighlight
                newData.locationDesc = locationDesc
                newData.name = name
                newData.reservable = reservable
                newData.startTime = startTime
                newData.thumbnailsUrl = thumbnailsUrl
                newData.isStageEvent = false
                newData.stageNo = 0
                newData.toImages = toImages
                newData.toVideos = toVideos
                newData.toTags = toTags
                newData.toFaculty = toFaculty
                return newData
            }
        }
        return nil
    }

    
    class func fetchActivityDetails( activityId: String, inManageobjectcontext context: NSManagedObjectContext ) -> ActivityData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        request.predicate = NSPredicate(format: "activityId = %@", activityId)
        
        do {
            
            let result = try context.fetch(request).first as? ActivityData
            
            return result
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
        return nil
        
    }

}
