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
        shortDesc: String,
        room: String,
        place: String,
        latitude: Double,
        longitude: Double,
        bannerUrl: String,
        thumbnailsUrl: String,
        startTime: String,
        endTime: String,
        isHighlight: Bool,
        video: String,
        pdf: String,
        images: [String],
        rounds: NSArray,
        tags: [String],
        faculty: String,
        inManageobjectcontext context: NSManagedObjectContext,
        completion: ((ActivityData?) -> Void)?
        )  {
            
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(request))?.first as? ActivityData
        {
            
            context.performAndWait {
                
                // created a new event in the database
                result.bannerUrl = bannerUrl == "" ? "" : "https://staff.chulaexpo.com\(bannerUrl)"
                result.desc = desc
                result.activityId = activityId
                result.room = room
                result.place = place
                result.latitude = latitude
                result.longitude = longitude
                result.name = name
                result.thumbnailsUrl = thumbnailsUrl == "" ? "" : "https://staff.chulaexpo.com\(thumbnailsUrl)"
                result.isHighlight = isHighlight
                result.stageNo = ActivityData.findStageNoFrom(placeId: place, incontext: context)
                result.video = video
                result.pdf = pdf
                result.faculty = faculty
                
                let toRemoveImageDatas = result.toImages?.allObjects as! [ImageData]
                let toRemoveTagDatas = result.toTags?.allObjects as! [TagData]
                let toRemoveroundDatas = result.toRound?.allObjects as! [RoundData]
                
                for imageData in toRemoveImageDatas {
                    
                    context.delete(imageData)
                    
                }
                
                for tagData in toRemoveTagDatas {
                 
                    context.delete(tagData)
                    
                }
                
                for roundData in toRemoveroundDatas {
                    
                    context.delete(roundData)
                    
                }
                
                for image in images {
                    
                    context.performAndWait {
                        
                        if let imageData = NSEntityDescription.insertNewObject(forEntityName: "ImageData", into: context) as? ImageData {
                            
                            imageData.url = image == "" ? "" : "https://staff.chulaexpo.com\(image)"
                            imageData.toActivity = result
                            
                        }
                        
                    }
                    
                }
                
                for tag in tags {
                    
                    context.performAndWait {
                        
                        if let tagData = NSEntityDescription.insertNewObject(forEntityName: "TagData", into: context) as? TagData {
                            
                            tagData.name = tag
                            tagData.mutableSetValue(forKey: "toActivity").add(result)
                            
                        }
                        
                    }
                    
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.calendar = Calendar(identifier: .gregorian)
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 25200)!
                dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                for round in rounds {
                    
                    if let round = round as? NSDictionary {
                        
                        context.performAndWait {
                            
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
                                roundData.toActivity = result
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            completion?(result)
            
        } else {
            
            if let activityData = NSEntityDescription.insertNewObject(forEntityName: "ActivityData", into: context) as? ActivityData
            {
                
                context.performAndWait {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.calendar = Calendar(identifier: .gregorian)
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 25200)!
                    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                    
                    // created a new event in the database
                    activityData.bannerUrl = bannerUrl == "" ? "" : "https://staff.chulaexpo.com\(bannerUrl)"
                    activityData.shortDesc = shortDesc
                    activityData.desc = desc
                    activityData.activityId = activityId
                    activityData.room = room
                    activityData.place = place
                    activityData.latitude = latitude
                    activityData.longitude = longitude
                    activityData.name = name
                    activityData.thumbnailsUrl = thumbnailsUrl == "" ? "" : "https://staff.chulaexpo.com\(thumbnailsUrl)"
                    activityData.isHighlight = isHighlight
                    activityData.stageNo = ActivityData.findStageNoFrom(placeId: place, incontext: context)
                    activityData.video = video
                    activityData.pdf = pdf
                    activityData.faculty = faculty
                    activityData.start = dateFormatter.date(from: startTime)
                    activityData.end = dateFormatter.date(from: endTime)
                    
                    for image in images {
                        
                        context.performAndWait {
                            
                            if let imageData = NSEntityDescription.insertNewObject(forEntityName: "ImageData", into: context) as? ImageData {
                                
                                imageData.url = image == "" ? "" : "https://staff.chulaexpo.com\(image)"
                                imageData.toActivity = activityData
                                
                            }
                            
                        }
                        
                    }
                    
                    for tag in tags {
                        
                        context.performAndWait {
                            
                            if let tagData = NSEntityDescription.insertNewObject(forEntityName: "TagData", into: context) as? TagData {
                                
                                tagData.name = tag
                                tagData.mutableSetValue(forKey: "toActivity").add(activityData)
                                
                            }
                            
                        }
                        
                    }
                    
                    for round in rounds {
                        
                        if let round = round as? NSDictionary {
                            
                            context.performAndWait {
                                
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
                        
                    }
                    
                }
                
                completion?(activityData)
                
            } else {
                
                completion?(nil)
                
            }
            
        }
        
    }
    
    class func fetchActivityData( activityId: String, inManageobjectcontext context: NSManagedObjectContext, completion: ((ActivityData?) -> Void)?) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "activityId = %@", activityId)
        
        if let result = (try? context.fetch(request))?.first as? ActivityData {
            
            completion?(result)
            
        } else {
            
            print("Couldn't fetch results")
            
            context.performAndWait {
                
                APIController.downloadActivity(fromActivityId: activityId, inManageobjectcontext: context, completion: { (activityData) in
                    
                    completion?(activityData)
                    
                    return
                    
                })
                
            }
            
            completion?(nil)
            
        }
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
    
    class func fetchActivityFromFullName(name: String, inManageobjectcontext context: NSManagedObjectContext) -> ActivityData? {
        
        var fetchResult: ActivityData?
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try context.fetch(request)
            
            for item in result{
                if let activityItem = item as? ActivityData{
                    fetchResult = activityItem
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
            case "58bc60c9e44acf38e95b2047":
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
