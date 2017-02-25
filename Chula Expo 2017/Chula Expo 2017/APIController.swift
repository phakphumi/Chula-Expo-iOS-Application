//
//  APIController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class APIController {
    
    class func getRoundsData(activityID: String, completion: @escaping (NSArray) -> Void) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities/\(activityID)/rounds").responseJSON { (response) in
            
            if let JSON = response.result.value as? NSDictionary{
                let results = JSON["results"] as! NSArray
                
                completion(results)
            }
            
        }
        
    }
    
    class func downloadRecommendActivities(inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        print("Download Recommend")
        Alamofire.request("http://staff.chulaexpo.com/api/activities?highlight=true&fields=_id&limit=10").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    context.performAndWait {
                        
                        _ = RecommendActivity.addData(activityId: result["_id"] as! String, inManageobjectcontext: context)
                        
                    }
                    
                }
                
                do{
                    
                    try context.save()
                    print("Recommend Data Saved")
                    completion?(true)
                    
                }
                    
                catch let error {
                    
                    print("Recommend Data save error with \(error)")
                    completion?(false)
                    
                }
                
            } else {
                
                completion?(false)
                
            }
            
        }
        
    }
    
    class func downloadStageActivities(inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        print("Download Stage")
        //download เวทีกลาง
        Alamofire.request("http://staff.chulaexpo.com/api/activities?zone=589c52dfa8bbbb1c7165d3f1&fields=_id").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    context.performAndWait {
                        
                        _ = StageActivity.addData(activityId: result["_id"] as! String, stage: 1, inManageobjectcontext: context)
                        
                    }
                    
                }
                
                do{
                    
                    try context.save()
                    print("Stage 1 Data Saved")
                    
                    Alamofire.request("http://staff.chulaexpo.com/api/activities?zone=589c5330a8bbbb1c7165d3f2&fields=_id").responseJSON { (response) in
                        
                        if response.result.isSuccess {
                            
                            let JSON = response.result.value as! NSDictionary
                            let results = JSON["results"] as! NSArray
                            
                            for result in results {
                                
                                let result = result as! NSDictionary
                                
                                context.performAndWait {
                                    
                                    _ = StageActivity.addData(activityId: result["_id"] as! String, stage: 2, inManageobjectcontext: context)
                                    
                                }
                                
                            }
                            
                            do{
                                
                                try context.save()
                                print("Stage 2 Data Saved")
                                
                                
                                Alamofire.request("http://staff.chulaexpo.com/api/activities?zone=589c536ca8bbbb1c7165d3f3&fields=_id").responseJSON { (response) in
                                    
                                    if response.result.isSuccess {
                                        
                                        let JSON = response.result.value as! NSDictionary
                                        let results = JSON["results"] as! NSArray
                                        
                                        for result in results {
                                            
                                            let result = result as! NSDictionary
                                            
                                            context.performAndWait {
                                                
                                                _ = StageActivity.addData(activityId: result["_id"] as! String, stage: 2, inManageobjectcontext: context)
                                                
                                            }
                                            
                                        }
                                        
                                        do{
                                            
                                            try context.save()
                                            print("Stage 3 Data Saved")
                                            completion?(true)
                                            
                                        }
                                            
                                        catch let error {
                                            
                                            print("Stage 3 Data save error with \(error)")
                                            completion?(false)
                                            
                                        }
                                        
                                    } else {
                                        
                                        completion?(false)
                                        
                                    }
                                    
                                }
                                
                            }
                                
                            catch let error {
                                
                                print("Stage 2 Data save error with \(error)")
                                completion?(false)
                                
                            }
                            
                        } else {
                            
                            completion?(false)
                            
                        }
                        
                    }
                    
                    
                }
                    
                catch let error {
                    
                    print("Stage 1 Data save error with \(error)")
                    completion?(false)
                    
                }
                
            } else {
                
                completion?(false)
                
            }
            
        }
        
    }
    
    class func downloadHightlightActivities(inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
     print("Download highlight")
        Alamofire.request("http://staff.chulaexpo.com/api/activities?highlight=true&fields=_id&limit=10").responseJSON { (response) in
            
            if response.result.isSuccess {

                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    context.performAndWait {
                        
                        _ = HighlightActivity.addData(activityId: result["_id"] as! String, inManageobjectcontext: context)
                        
                    }

                }
                
                do{
                    
                    try context.save()
                    print("Highlight Data Saved")
                    completion?(true)
                    
                }
                    
                catch let error {
                    
                    print("Hightlight Data save error with \(error)")
                    completion?(false)
                    
                }
                
            } else {
                
                completion?(false)
                
            }
            
        }
        
    }
    
    class func downloadActivity(fromActivityId activityId: String, inManageobjectcontext context: NSManagedObjectContext, completion: @escaping (ActivityData?) -> Void) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities/\(activityId)").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                let JSON = response.result.value as! NSDictionary
                let result = JSON["results"] as! NSDictionary
                    
                let location = result["location"] as! NSDictionary
                
                let startTime = result["start"] as! String
                
                let endTime = result["end"] as! String
                
                let pictures = result["pictures"] as? [String] ?? [""]
                
                let tags = result["tags"] as! [String]
                
                var activityData: ActivityData?
                
                APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                    
                    context.performAndWait {
                        
                        activityData = ActivityData.addEventData(
                            
                            activityId: result["_id"] as? String ?? "",
                            name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                            desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                            room: location["room"] as? String ?? "",
                            place: location["place"] as? String ?? "",
                            latitude: location["latitude"] as? Double ?? 0.0,
                            longitude: location["longitude"] as? Double ?? 0.0,
                            bannerUrl: result["banner"] as? String ?? "",
                            thumbnailsUrl: result["thumbnail"] as? String ?? "",
                            startTime: dateFormatter.date(from: startTime) ?? Date(),
                            endTime: dateFormatter.date(from: endTime) ?? Date(),
                            isHighlight: result["isHighlight"] as? Bool ?? false,
                            video: result["video"] as? String ?? "",
                            pdf: result["pdf"] as? String ?? "",
                            images: pictures,
                            rounds: rounds,
                            tags: tags,
                            faculty: result["zone"] as? String ?? "",
                            inManageobjectcontext: context
                        )
                    }
                })
                
                do{
                    
                    try context.save()
                    print("ActivityData Saved")
                    
                    completion(activityData)
                    
                }
                    
                catch let error {
                    
                    print("ActivityData save error with \(error)")
                    
                    completion(nil)
                    
                }
                
            } else {
                
                completion(nil)
                
            }
            
        }
        
    }
    
    class func downloadActivities(inManageobjectcontext context: NSManagedObjectContext) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                //                print(results)
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let location = result["location"] as! NSDictionary
                    
                    let startTime = result["start"] as! String
                    
                    let endTime = result["end"] as! String
                    
                    let pictures = result["pictures"] as? [String] ?? [""]
                    
                    let tags = result["tags"] as! [String]
                    
                    APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                        
                        context.performAndWait {
                            
                            _ = ActivityData.addEventData(
                                
                                activityId: result["_id"] as? String ?? "",
                                name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                room: location["room"] as? String ?? "",
                                place: location["place"] as? String ?? "",
                                latitude: location["latitude"] as? Double ?? 0.0,
                                longitude: location["longitude"] as? Double ?? 0.0,
                                bannerUrl: result["banner"] as? String ?? "",
                                thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                startTime: dateFormatter.date(from: startTime) ?? Date(),
                                endTime: dateFormatter.date(from: endTime) ?? Date(),
                                isHighlight: result["isHighlight"] as? Bool ?? false,
                                video: result["video"] as? String ?? "",
                                pdf: result["pdf"] as? String ?? "",
                                images: pictures,
                                rounds: rounds,
                                tags: tags,
                                faculty: result["zone"] as? String ?? "",
                                inManageobjectcontext: context
                            )
                        }
                    })
                    
                }
                
                do{
                    
                    try context.save()
                    print("ActivityData Saved")
                    
                }
                    
                catch let error {
                    
                    print("ActivityData save error with \(error)")
                    
                }
                
            }
            
        }
        
    }
    
    class func downloadZone(inManageobjectcontext context: NSManagedObjectContext) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/zones").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    
                    let shortName = result["shortName"] as! NSDictionary
                    
                    let desc = result["description"] as! NSDictionary
                    
                    let location = result["location"] as! NSDictionary
                    
                    let welcomeMsg = result["welcomeMessage"] as! NSDictionary
                    
                    
                    context.performAndWait {
                        
                        _ = ZoneData.addData(id: result["_id"] as! String,
                                             type: result["type"] as! String,
                                             shortName: shortName["en"] as? String ?? "",
                                             desc: desc["en"] as? String ?? "",
                                             longitude: location["longitude"] as! Double,
                                             latitude: location["latitude"] as! Double,
                                             name: name["en"] as! String,
                                             nameTh: name["th"] as! String,
                                             welcomeMessage: welcomeMsg["th"] as? String ?? "",
                                             inManageobjectcontext: context)
                        
                    }
                    
                    do{
                        
                        try context.save()
                        print("ZoneData Saved")
                        
                    }
                        
                    catch let error {
                        
                        print("ZoneData save error with \(error)")
                        
                    }
                    
                }
                
                APIController.downloadPlace(inManageobjectcontext: context)
                
            }
            
        }
        
    }

    
    class func downloadPlace(inManageobjectcontext context: NSManagedObjectContext) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/places").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    
                    let location = result["location"] as! NSDictionary
                    
                    context.performAndWait {
                        
                        _ = PlaceData.addData(id: result["_id"] as! String,
                                              code: result["code"] as! String,
                                              nameTh: name["th"] as! String,
                                              nameEn: name["en"] as! String,
                                              longitude: location["longitude"] as! Double,
                                              latitude: location["latitude"] as! Double,
                                              zoneID: result["zone"] as! String,
                                              inManageobjectcontext: context)
                        
                    }
                    
                    do {
                        
                        try context.save()
                        print("PlaceData Saved")
                        
                    }
                        
                    catch let error {
                        
                        print("PlaceData save error with \(error)")
                        
                    }
                    
                }
                
                APIController.downloadRoom(inManageobjectcontext: context)
                
            }
            
        }
        
    }

    
    class func downloadRoom(inManageobjectcontext context: NSManagedObjectContext) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/rooms").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    
                    context.performAndWait {
                        
                        _ = RoomData.addData(id: result["_id"] as! String,
                                             floor: result["floor"] as! String,
                                             name: name["th"] as! String,
                                             placeID: result["place"] as! String,
                                             inManageobjectcontext: context)
                        
                    }
                    
                    do{
                        
                        try context.save()
                        print("RoomData Saved")
                        
                    }
                        
                    catch let error {
                        
                        print("RoomData save error with \(error)")
                        
                    }
                    
                }
                
            }
            
        }
        
    }

    
    class func downloadFacility(inManageobjectcontext context: NSManagedObjectContext) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/facilities").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    let desc = result["description"] as! NSDictionary
                    let location = result["location"] as! NSDictionary
                    
                    context.performAndWait {
                        
                        _ = FacilityData.addData(id: result["_id"] as! String,
                                                 nameTh: name["th"] as! String,
                                                 nameEn: name["en"] as! String,
                                                 descTh: desc["th"] as! String,
                                                 descEn: desc["en"] as! String,
                                                 type: result["type"] as! String,
                                                 latitude: location["latitude"] as! Double,
                                                 longitude: location["longitude"] as! Double,
                                                 placeID: result["place"] as! String,
                                                 inManageobjectcontext: context)
                        
                    }
                    
                    do{
                        
                        try context.save()
                        print("FacilityData Saved")
                        
                    }
                        
                    catch let error {
                        
                        print("FacilityData save error with \(error)")
                        
                    }
                    
                }
                
            }
            
        }
        
    }

    
    class func downloadReserved(inManageobjectcontext context: NSManagedObjectContext) {
        
        if let userData = UserData.fetchUser(inManageobjectcontext: context) {
        
            let header: HTTPHeaders = ["Authorization": "JWT \(userData.token!)"]
        
            Alamofire.request("http://staff.chulaexpo.com/api/me/reserved_rounds?fields=activityId", headers: header).responseJSON(completionHandler: { (response) in
        
                if response.result.isSuccess {
        
                    if let JSON = response.result.value as? NSDictionary {
        
                        if let results = JSON["results"] as? NSArray {
        
                            context.performAndWait {
                                
                                for result in results {

                                    let result = result as! NSDictionary
                                    
                                    _ = ReservedActivity.addData(activityId: result["activityId"] as! String, inManageobjectcontext: context)
                                    
                                }
                                
                            }
                            
                            do{
                                
                                try context.save()
                                print("Reserved Activity Saved")
                                
                            }
                                
                            catch let error {
                                
                                print("Reserved Activity save error with \(error)")
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
}
