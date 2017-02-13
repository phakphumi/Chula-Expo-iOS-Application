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
    
    class func addEventData(
        activityId: String,
        name: String,
        desc: String,
        room: String,
        place: String,
        latitude: Double,
        longitude: Double,
        bannerUrl: String,
        thumbnailsUrl: String,
        startTime: Date,
        endTime: Date,
        isFavorite: Bool,
        isHighlight: Bool,
        reservable: Bool,
        fullCapacity: Int16,
        reserved: Int16,
        seatAvaliable: Int16,
        isReserve: Bool,
        video: String,
        images: [String],
        rounds: NSArray,
        tags: [String],
        faculty: String,
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
            if let activityData = NSEntityDescription.insertNewObject(forEntityName: "ActivityData", into: context) as? ActivityData
            {
                // created a new event in the database
                activityData.bannerUrl = bannerUrl
                activityData.desc = desc
                activityData.activityId = activityId
                activityData.room = room
                activityData.place = place
                activityData.latitude = latitude
                activityData.longitude = longitude
                activityData.name = name
                activityData.reservable = reservable
                activityData.thumbnailsUrl = thumbnailsUrl
                activityData.isHighlight = isHighlight
                activityData.isStageEvent = false
                activityData.stageNo = 0
                activityData.video = video
//                newData.toImages = toImages
//                newData.toRound = toRounds
//                newData.toTags = toTags
                activityData.faculty = faculty
                
                for image in images {
                    
                    if let imageData = NSEntityDescription.insertNewObject(forEntityName: "ImageData", into: context) as? ImageData {
                        
                        imageData.url = image
                        imageData.toActivity = activityData
                        
                    }
                    
                }
                
                for tag in tags {
                    
                    if let tagData = NSEntityDescription.insertNewObject(forEntityName: "TagData", into: context) as? TagData {
                        
                        tagData.name = tag
                        tagData.mutableSetValue(forKey: "toActivity").add(activityData)
                        
                    }
                    
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                for round in rounds {
                    
                    if let round = round as? NSDictionary {
                        
                        if let roundData = NSEntityDescription.insertNewObject(forEntityName: "RoundData", into: context) as? RoundData {
                            
                            let startTime = round["start"] as! String
                            let endTime = round["end"] as! String
                            
                            let seats = round["seats"] as! NSDictionary
                            
                            roundData.id = round["_id"] as? String ?? ""
                            roundData.activityId = round["activityId"] as? String ?? ""
                            roundData.startTime = dateFormatter.date(from: startTime)
                            roundData.endTime = dateFormatter.date(from: endTime)
                            roundData.fullCapacity = seats["fullCapacity"] as! Int16
                            roundData.reserved = seats["reserved"] as! Int16
                            roundData.seatAvaliable = seats["avaliable"] as! Int16
                            roundData.isFavorite = false
                            roundData.isReserve = false
                            roundData.reservable = (seats["avaliable"] as! Int16) > 0 ? true : false
                            roundData.toActivity = activityData
                            
                        }
                        
                    }
                    
                }
                
                return activityData
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
    
    class func fetchActivityFromSearch(name: String, inManageobjectcontext context: NSManagedObjectContext) -> [ActivityData]{
        
        var fetchResult = [ActivityData]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
        
        do {
            let result = try context.fetch(request)
            
            for item in result{
                if let activityItem = item as? ActivityData{
                    fetchResult.append(activityItem)
                }
            }
            
        } catch {
            print("Couldn't fetch results")
        }
        
            return fetchResult
    }

    
//    func addRound(
//        roundNo: Int16,
//        starTime: NSDate,
//        endTime: NSDate,
//        reservable: Bool,
//        seatAvaliable: Int16,
//        reserved: Int16,
//        fullCapacity: Int16,
//        isReserve: Bool,
//        isFavorite: Bool,
//        isHighlight: Bool,
//        inManageobjectcontext context: NSManagedObjectContext
//        ){
//        
//        toRound = toRound?.adding(RoundData.addData(id: id!, activityId: activityId!, roundNo: roundNo, startTime: starTime, endTime: endTime, reservable: reservable, seatAvaliable: seatAvaliable, reserved: reserved, fullCapacity: fullCapacity, isReserve: isReserve, isFavorite: isFavorite, isHighlight: isHighlight, inManageobjectcontext: context)!) as NSSet?
//    }
}
