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
        isHighlight: Bool,
        video: String,
        pdf: String,
        images: [String],
        rounds: NSArray,
        tags: [String],
        faculty: String,
        inManageobjectcontext context: NSManagedObjectContext,
        completion: ((Bool) -> Void)?
        )  {
        
        context.performAndWait {
            
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            request.predicate = NSPredicate(format: "activityId = %@",  activityId)
            
            if let result = (try? context.fetch(request))?.first as? ActivityData
            {
                
                //            result.name = name
                //            result.desc = desc
                //            result.room = room
                //            result.place = place
                //            result.latitude = latitude
                //            result.longitude = longitude
                //            result.bannerUrl = bannerUrl
                //            result.thumbnailsUrl = thumbnailsUrl
                //            result.video = video
                //            result.pdf = pdf
                //            result.faculty = faculty
                //            result.stageNo = ActivityData.findStageNoFrom(placeId: place, incontext: context)
                print("  Found \(result.name) in ActivityData")
                
                completion?(false)
            }
            else {
                if let activityData = NSEntityDescription.insertNewObject(forEntityName: "ActivityData", into: context) as? ActivityData
                {
                    
                    // created a new event in the database
                    activityData.bannerUrl = bannerUrl == "" ? "" : "http://staff.chulaexpo.com\(bannerUrl)"
                    activityData.desc = desc
                    activityData.activityId = activityId
                    activityData.room = room
                    activityData.place = place
                    activityData.latitude = latitude
                    activityData.longitude = longitude
                    activityData.name = name
                    activityData.thumbnailsUrl = thumbnailsUrl == "" ? "" : "http://staff.chulaexpo.com\(thumbnailsUrl)"
                    activityData.isHighlight = isHighlight
                    activityData.stageNo = ActivityData.findStageNoFrom(placeId: place, incontext: context)
                    activityData.video = video
                    activityData.pdf = pdf
                    activityData.faculty = faculty
                    
                    //                newData.toImages = toImages
                    //                newData.toRound = toRounds
                    //                newData.toTags = toTags
                    
                    
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
                                roundData.toActivity = activityData
                                
                            }
                            
                        }
                        
                    }
                    
                    completion?(true)
                    
                } else {
                    
                    completion?(false)
                    
                }
                
            }
            
        }
        
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
    
    class func fetchHighlightFromAll(inManageobjectcontext context: NSManagedObjectContext) -> [ActivityData]{
        
        var fetchResult = [ActivityData]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "isHighlight = true")
        
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
    
    class func findStageNoFrom(placeId: String, incontext context: NSManagedObjectContext) -> Int16 {
        
        var stage:Int16 = 0
        
        context.performAndWait {
            
            let zoneId = ZoneData.fetchZoneFromPlace(id: placeId, incontext: context)
            
            switch zoneId{
            case "589c52dfa8bbbb1c7165d3f1":
                stage = 1
            case "589c5330a8bbbb1c7165d3f2":
                stage = 2
            case "589c536ca8bbbb1c7165d3f3":
                stage = 3
            default:
                break
            }
        }
        
        return stage
        
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
