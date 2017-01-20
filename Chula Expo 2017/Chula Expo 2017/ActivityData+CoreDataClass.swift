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
        faculty: String,
        id: Int16,
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
        inManageobjectcontext context: NSManagedObjectContext
        ) -> ActivityData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "name = %@ AND id = %i", name, id)
        
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
                newData.faculty = faculty
                newData.id = id
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
                return newData
            }
        }
        return nil
    }

}
