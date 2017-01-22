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
    
    class func addData(
        bannerUrl: String,
        desc: String,
        endTime: NSDate,
        activityId: String,
        isFavorite: Bool,
        isHighlight: Bool,
        isReserve: Bool,
        locationDesc: String,
        name: String,
        reservable: Bool,
        startTime: NSDate,
        thumbnailsUrl: String,
        isStageEvent: Bool,
        toImages: NSSet,
        toVideos: NSSet,
        toTags: NSSet,
        toFaculty: NSSet,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> ActivityData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "name = %@ AND activityId = %@", name, activityId)
        
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
                newData.isStageEvent = isStageEvent
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
