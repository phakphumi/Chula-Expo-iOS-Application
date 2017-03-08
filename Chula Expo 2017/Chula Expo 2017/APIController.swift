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
    
    class func getWhereAmI(latitude: Double, longitude: Double, inManageobjectcontext context: NSManagedObjectContext, completion: (([String: String]?) -> Void)?) {
        
        if let userData = UserData.fetchUser(inManageobjectcontext: context) {
            
            let parameters: [String: Any] = [
                "latitude": latitude,
                "longitude": longitude
            ]
            
            let header: HTTPHeaders = ["Authorization": "JWT \(userData.token!)"]
            
            Alamofire.request("http://staff.chulaexpo.com/api/me/where", method: .get, parameters: parameters, headers: header).responseJSON(completionHandler: { (response) in
             
                if response.result.isSuccess {
                    
                    if let JSON = response.result.value as? NSDictionary{
                        
                        let success = JSON["success"] as! Bool
                        
                        if success {
                            
                            let results = JSON["results"] as! NSDictionary
                            let zone = results["text"] as! [String: String]
                            
                            completion?(zone)
                            
                        }
                        
                    }
                    
                } else {
                    
                    completion?(nil)
                    
                }
                
            })
            
        } else {
            
            let parameters: [String: Any] = [
                "latitude": latitude,
                "longitude": longitude
            ]
            
            Alamofire.request("http://staff.chulaexpo.com/api/me/where", method: .get, parameters: parameters).responseJSON(completionHandler: { (response) in
                
                if response.result.isSuccess {
                    
                    if let JSON = response.result.value as? NSDictionary{
                        
                        let success = JSON["success"] as! Bool
                        
                        if success {
                            
                            let results = JSON["results"] as! NSDictionary
                            let zone = results["text"] as! [String: String]
                            
                            completion?(zone)
                            
                        }
                        
                    }
                    
                } else {
                    
                    completion?(nil)
                    
                }
                
            })
            
        }
        
    }
    
    class func sendComment(toActivityID id: String, message: String, inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        
        let parameters: [String: Any] = [
            "activity": id,
            "message": message
        ]
        
        if let userData = UserData.fetchUser(inManageobjectcontext: context) {
                
            let header: HTTPHeaders = ["Authorization": "JWT \(userData.token!)"]
            
            Alamofire.request("http://staff.chulaexpo.com/api/comments", method: .post, parameters: parameters, headers: header).responseJSON(completionHandler: { (response) in
         
                if response.result.isSuccess {
                    
                    if let JSON = response.result.value as? NSDictionary{

                        let results = JSON["success"] as! Bool
                        
                        completion?(results)
                    
                    }
                    
                } else {
                    
                    completion?(false)
                    
                }
                
            })
            
        }
        
    }
    
    class func getRoundsData(activityID: String, completion: @escaping (NSArray) -> Void) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities/\(activityID)/rounds").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                if let JSON = response.result.value as? NSDictionary{
                    let results = JSON["results"] as! NSArray
                    
                    completion(results)
                }
                
            }
            
        }
        
    }
    
    class func downloadNearbyActivities(fromLatitude latitude: Double, longitude: Double, inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        
        if let userData = UserData.fetchUser(inManageobjectcontext: context) {
            
            let header: HTTPHeaders! = ["Authorization": "JWT \(userData.token!)"]
            
            let parameters: [String: Any] = [
                "latitude": latitude,
                "longitude": longitude
            ]
            
            Alamofire.request("http://staff.chulaexpo.com/api/activities/nearby", method: .get, parameters: parameters, headers: header).responseJSON { (response) in
                
                if response.result.isSuccess {
                    
                    let fetchNearbyData = NSFetchRequest<NSFetchRequestResult>(entityName: "NearbyActivity")
                    let requestDeleteNearbyData = NSBatchDeleteRequest(fetchRequest: fetchNearbyData)
                    
                    do {
                        
                        try context.execute(requestDeleteNearbyData)
                        
                    } catch let error {
                        
                        print(error)
                        
                    }
                    
                    let JSON = response.result.value as! NSDictionary
                    
                    let results = JSON["results"] as! NSArray
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                    
                    context.performAndWait {
                        
                        for result in results {
                            
                            let result = result as! NSDictionary
                            
                            let location = result["location"] as! NSDictionary
                            
                            let startTime = result["start"] as! String
                            
                            let endTime = result["end"] as! String
                            
                            let pictures = result["pictures"] as? [String] ?? [""]
                            
                            let tags = result["tags"] as! [String]
                            
                            APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                                
                                context.performAndWait {
                                    
                                    ActivityData.addEventData(
                                        
                                        activityId: result["_id"] as? String ?? "",
                                        name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                        desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                        shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                        room: location["room"] as? String ?? "",
                                        place: location["place"] as? String ?? "",
                                        latitude: location["latitude"] as? Double ?? 0.0,
                                        longitude: location["longitude"] as? Double ?? 0.0,
                                        bannerUrl: result["banner"] as? String ?? "",
                                        thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                        startTime: startTime,
                                        endTime: endTime,
                                        isHighlight: result["isHighlight"] as? Bool ?? false,
                                        video: result["video"] as? String ?? "",
                                        pdf: result["pdf"] as? String ?? "",
                                        images: pictures,
                                        rounds: rounds,
                                        tags: tags,
                                        faculty: result["zone"] as? String ?? "",
                                        inManageobjectcontext: context,
                                        completion: { (activityData) in
                                            
                                            if let activityData = activityData {
                                                
                                                context.performAndWait {
                                                    
                                                    NearbyActivity.addData(activityId: activityData.activityId!,
                                                                              activityData: activityData,
                                                                              inManageobjectcontext: context,
                                                                              completion: { (nearbyActivity) in
                                                                                
                                                                                if nearbyActivity != nil {
                                                                                    
                                                                                    context.performAndWait {
                                                                                        
                                                                                        if EntityHistory.isThereHistory(forEntityName: "NearbyActivity", inManageobjectcontext: context) {
                                                                                            
                                                                                            _ = EntityHistory.updateHistory(forEntityName: "NearbyActivity", inManageobjectcontext: context)
                                                                                            //                                                                                    print("Update Recommend History")
                                                                                            
                                                                                        } else {
                                                                                            
                                                                                            _ = EntityHistory.addHistory(forEntityName: "NearbyActivity", inManageobjectcontext: context)
                                                                                            //                                                                                    print("Create Recommend History")
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                
                                                    })
                                                    
                                                }
                                                
                                            }
                                            
                                    })
                                    
                                }
                                
                                do{
                                    
                                    try context.save()
                                    
                                }
                                    
                                catch let error {
                                    
                                    print("Nearby Data save error with \(error)")
                                    completion?(false)
                                    
                                    return
                                    
                                }
                                
                            })
                            
                        }
                        
                    }
                    
                    completion?(true)
                    
                } else {
                    
                    completion?(false)
                    
                }
                
            }
            
        }
        
    }
    
    class func downloadRecommendActivities(inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        
        if let userData = UserData.fetchUser(inManageobjectcontext: context) {
            
            let header: HTTPHeaders! = ["Authorization": "JWT \(userData.token!)"]
            
            Alamofire.request("http://staff.chulaexpo.com/api/activities/recommend", method: .get, headers: header).responseJSON { (response) in
                
                if response.result.isSuccess {
                    
                    let fetchRecommendData = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
                    let requestDeleteRecommendData = NSBatchDeleteRequest(fetchRequest: fetchRecommendData)
                    
                    do {
                        
                        try context.execute(requestDeleteRecommendData)
                        
                    } catch let error {
                        
                        print(error)
                        
                    }
                    
                    let JSON = response.result.value as! NSDictionary
                    
                    let results = JSON["results"] as! NSArray
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                    
                    context.performAndWait {
                        
                        for result in results {
                            
                            let result = result as! NSDictionary
                            
                            let location = result["location"] as! NSDictionary
                            
                            let startTime = result["start"] as! String
                            
                            let endTime = result["end"] as! String
                            
                            let pictures = result["pictures"] as? [String] ?? [""]
                            
                            let tags = result["tags"] as! [String]
                            
                            APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                                
                                context.performAndWait {
                                    
                                    ActivityData.addEventData(
                                        
                                        activityId: result["_id"] as? String ?? "",
                                        name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                        desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                        shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                        room: location["room"] as? String ?? "",
                                        place: location["place"] as? String ?? "",
                                        latitude: location["latitude"] as? Double ?? 0.0,
                                        longitude: location["longitude"] as? Double ?? 0.0,
                                        bannerUrl: result["banner"] as? String ?? "",
                                        thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                        startTime: startTime,
                                        endTime: endTime,
                                        isHighlight: result["isHighlight"] as? Bool ?? false,
                                        video: result["video"] as? String ?? "",
                                        pdf: result["pdf"] as? String ?? "",
                                        images: pictures,
                                        rounds: rounds,
                                        tags: tags,
                                        faculty: result["zone"] as? String ?? "",
                                        inManageobjectcontext: context,
                                        completion: { (activityData) in
                                            
                                            if let activityData = activityData {
                                                
                                                context.performAndWait {
                                                    
                                                    RecommendActivity.addData(activityId: activityData.activityId!,
                                                                              activityData: activityData,
                                                                              inManageobjectcontext: context,
                                                                              completion: { (recommendActivity) in
                                                                                
                                                                                if recommendActivity != nil {
                                                                                    
                                                                                    context.performAndWait {
                                                                                        
                                                                                        if EntityHistory.isThereHistory(forEntityName: "RecommendActivity", inManageobjectcontext: context) {
                                                                                            
                                                                                            _ = EntityHistory.updateHistory(forEntityName: "RecommendActivity", inManageobjectcontext: context)
                                                                                            //                                                                                    print("Update Recommend History")
                                                                                            
                                                                                        } else {
                                                                                            
                                                                                            _ = EntityHistory.addHistory(forEntityName: "RecommendActivity", inManageobjectcontext: context)
                                                                                            //                                                                                    print("Create Recommend History")
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                
                                                    })
                                                    
                                                }
                                                
                                            }
                                            
                                    })
                                    
                                }
                                
                                do{
                                    
                                    try context.save()

                                }
                                    
                                catch let error {
                                    
                                    print("Recommend Data save error with \(error)")
                                    completion?(false)
                                    
                                    return
                                    
                                }
                                
                            })
                            
                        }
                        
                    }
                    
                    completion?(true)
                    
                } else {
                    
                    completion?(false)
                    
                }
                
            }
            
        } else {
            
            let dateRequestFormatter = DateFormatter()
            dateRequestFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateRequestFormatter.timeZone = TimeZone(secondsFromGMT: 7)
            
            let currentTime = dateRequestFormatter.string(from: Date())
            
            let parameters: [String: Any] = [
                "highlight": true,
                "start": [
                    "gte": currentTime,
                ],
                "limit": 20
            ]
            
            Alamofire.request("http://staff.chulaexpo.com/api/activities", method: .get, parameters: parameters).responseJSON { (response) in
                
                if response.result.isSuccess {
                    
                    let JSON = response.result.value as! NSDictionary
                    
                    let results = JSON["results"] as! NSArray
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                    
                    context.performAndWait {
                        
                        for result in results {
                            
                            let result = result as! NSDictionary
                            
                            let location = result["location"] as! NSDictionary
                            
                            let startTime = result["start"] as! String
                            
                            let endTime = result["end"] as! String
                            
                            let pictures = result["pictures"] as? [String] ?? [""]
                            
                            let tags = result["tags"] as! [String]
                            
                            APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                                
                                context.performAndWait {
                                    
                                    ActivityData.addEventData(
                                        
                                        activityId: result["_id"] as? String ?? "",
                                        name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                        desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                        shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                        room: location["room"] as? String ?? "",
                                        place: location["place"] as? String ?? "",
                                        latitude: location["latitude"] as? Double ?? 0.0,
                                        longitude: location["longitude"] as? Double ?? 0.0,
                                        bannerUrl: result["banner"] as? String ?? "",
                                        thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                        startTime: startTime,
                                        endTime: endTime,
                                        isHighlight: result["isHighlight"] as? Bool ?? false,
                                        video: result["video"] as? String ?? "",
                                        pdf: result["pdf"] as? String ?? "",
                                        images: pictures,
                                        rounds: rounds,
                                        tags: tags,
                                        faculty: result["zone"] as? String ?? "",
                                        inManageobjectcontext: context,
                                        completion: { (activityData) in
                                            
                                            if let activityData = activityData {
                                                
                                                context.performAndWait {
                                                    
                                                    RecommendActivity.addData(activityId: activityData.activityId!,
                                                                              activityData: activityData,
                                                                              inManageobjectcontext: context,
                                                                              completion: { (recommendActivity) in
                                                                                
                                                                                if recommendActivity != nil {
                                                                                    
                                                                                    context.performAndWait {
                                                                                        
                                                                                        if EntityHistory.isThereHistory(forEntityName: "RecommendActivity", inManageobjectcontext: context) {
                                                                                            
                                                                                            _ = EntityHistory.updateHistory(forEntityName: "RecommendActivity", inManageobjectcontext: context)
                                                                                            //                                                                                    print("Update Recommend History")
                                                                                            
                                                                                        } else {
                                                                                            
                                                                                            _ = EntityHistory.addHistory(forEntityName: "RecommendActivity", inManageobjectcontext: context)
                                                                                            //                                                                                    print("Create Recommend History")
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                
                                                    })
                                                    
                                                }
                                                
                                            }
                                            
                                    })
                                    
                                }
                                
                                do{
                                    
                                    try context.save()
                                    
                                }
                                    
                                catch let error {
                                    
                                    print("Recommend Data save error with \(error)")
                                    completion?(false)
                                    
                                    return
                                    
                                }
                                
                            })
                            
                        }
                        
                    }
                    
                    completion?(true)
                    
                } else {
                    
                    completion?(false)
                    
                }
                
            }
            
            
        }
        
        
    }
    
    class func downloadStageActivities(inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        
        //download เวทีกลาง
        let parameters: [[String: Any]] = [
                                            ["zone": "589c52dfa8bbbb1c7165d3f1"], // เวทีกลาง
                                            ["zone": "589c5330a8bbbb1c7165d3f2"], // CU Hall
                                            ["zone": "58bc60c9e44acf38e95b2047"]  // ศาลาพระเกี้ยว
        ]
        
        context.performAndWait {
            
        
            for i in 0...2 {
                
                context.performAndWait {
                    
                    Alamofire.request("http://staff.chulaexpo.com/api/activities", method: .get, parameters: parameters[i]).responseJSON(completionHandler: { (response) in
                        
                        if response.result.isSuccess {
                            
                            let JSON = response.result.value as! NSDictionary
                            
                            let results = JSON["results"] as! NSArray
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                            
                            for result in results {
                                
                                let result = result as! NSDictionary
                                
                                let location = result["location"] as! NSDictionary
                                
                                let startTime = result["start"] as! String
                                
                                let endTime = result["end"] as! String
                                
                                let pictures = result["pictures"] as? [String] ?? [""]
                                
                                let tags = result["tags"] as! [String]
                                
                                APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                                    
                                    context.performAndWait {
                                        
                                        ActivityData.addEventData(
                                            
                                            activityId: result["_id"] as? String ?? "",
                                            name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                            desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                            shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                            room: location["room"] as? String ?? "",
                                            place: location["place"] as? String ?? "",
                                            latitude: location["latitude"] as? Double ?? 0.0,
                                            longitude: location["longitude"] as? Double ?? 0.0,
                                            bannerUrl: result["banner"] as? String ?? "",
                                            thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                            startTime: startTime,
                                            endTime: endTime,
                                            isHighlight: result["isHighlight"] as? Bool ?? false,
                                            video: result["video"] as? String ?? "",
                                            pdf: result["pdf"] as? String ?? "",
                                            images: pictures,
                                            rounds: rounds,
                                            tags: tags,
                                            faculty: result["zone"] as? String ?? "",
                                            inManageobjectcontext: context,
                                            completion: { (activityData) in
                                                
                                                if let activityData = activityData {
                                                    
                                                    context.performAndWait {
                                                        
                                                        StageActivity.addData(activityId: activityData.activityId!,
                                                                              activityData: activityData,
                                                                              stage: i+1,
                                                                              inManageobjectcontext: context,
                                                                              completion: { (stageActivity) in
                                                                                
                                                                                if stageActivity != nil {
                                                                                    
                                                                                    context.performAndWait {
                                                                                        
                                                                                        if EntityHistory.isThereHistory(forEntityName: "StageActivity", inManageobjectcontext: context) {
                                                                                            
                                                                                            _ = EntityHistory.updateHistory(forEntityName: "StageActivity", inManageobjectcontext: context)
                                                                                            //                                                                                        print("Update Stage\(i+1) History")
                                                                                            
                                                                                        } else {
                                                                                            
                                                                                            _ = EntityHistory.addHistory(forEntityName: "StageActivity", inManageobjectcontext: context)
                                                                                            //                                                                                        print("Create Stage\(i+1) History")
                                                                                            
                                                                                        }
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                
                                                        })
                                                        
                                                    }
                                                    
                                                }
                                                
                                        })
                                        
                                    }
                                    
                                    do{
                                        
                                        try context.save()
                                        
                                    }
                                        
                                    catch let error {
                                        
                                        print("Stage Data save error with \(error)")
                                        completion?(false)
                                        
                                        return
                                        
                                    }
                                    
                                })
                                
                            }
                            
                        } else {
                            
                            completion?(false)
                            
                            return
                            
                        }
                        
                    })
                    
                }
                
            }   
            
        }
        
        completion?(true)
        
    }
    
    class func downloadHightlightActivities(inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
     
//        let dateRequestFormatter = DateFormatter()
//        dateRequestFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
//        dateRequestFormatter.timeZone = TimeZone(secondsFromGMT: 7)
//        
//        let currentTime = dateRequestFormatter.string(from: Date())
//        
        let parameters: [String: Any] = [
//            "highlight": true,
//            "start": [
//                    "gte": currentTime,
//            ],
            "limit": 10
        ]
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities/highlight", method: .get, parameters: parameters).responseJSON { (response) in
          
            if response.result.isSuccess {
                
                let fetchHighlightData = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
                let requestDeleteHighlightData = NSBatchDeleteRequest(fetchRequest: fetchHighlightData)
                
                do {
                    
                    try context.execute(requestDeleteHighlightData)
                    
                } catch let error {
                    
                    print(error)
                    
                }
                
                let JSON = response.result.value as! NSDictionary
          
                let results = JSON["results"] as! NSArray
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                context.performAndWait {
                    
                    
                    for result in results {
                        
                        let result = result as! NSDictionary
                        
                        let location = result["location"] as! NSDictionary
                        
                        let startTime = result["start"] as! String
                        
                        let endTime = result["end"] as! String
                        
                        let pictures = result["pictures"] as? [String] ?? [""]
                        
                        let tags = result["tags"] as! [String]
                        
                        APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                            
                            context.performAndWait {
                                
                                ActivityData.addEventData(
                                    
                                    activityId: result["_id"] as? String ?? "",
                                    name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                    desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                    shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                    room: location["room"] as? String ?? "",
                                    place: location["place"] as? String ?? "",
                                    latitude: location["latitude"] as? Double ?? 0.0,
                                    longitude: location["longitude"] as? Double ?? 0.0,
                                    bannerUrl: result["banner"] as? String ?? "",
                                    thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                    startTime: startTime,
                                    endTime: endTime,
                                    isHighlight: result["isHighlight"] as? Bool ?? false,
                                    video: result["video"] as? String ?? "",
                                    pdf: result["pdf"] as? String ?? "",
                                    images: pictures,
                                    rounds: rounds,
                                    tags: tags,
                                    faculty: result["zone"] as? String ?? "",
                                    inManageobjectcontext: context,
                                    completion: { (activityData) in
                                        
                                        if let activityData = activityData {
                                            
                                            context.performAndWait {
                                                
                                                HighlightActivity.addData(activityId: activityData.activityId!,
                                                                          activityData: activityData, inManageobjectcontext: context,
                                                                          completion: { (highlightActivity) in
                                                                            
                                                                            if highlightActivity != nil {
                                                                                
                                                                                context.performAndWait {
                                                                                    
                                                                                    if EntityHistory.isThereHistory(forEntityName: "HighlightActivity", inManageobjectcontext: context) {
                                                                                        
                                                                                        _ = EntityHistory.updateHistory(forEntityName: "HighlightActivity", inManageobjectcontext: context)
                                                                                        //                                                                                    print("Update Highlight History")
                                                                                        
                                                                                    } else {
                                                                                        
                                                                                        _ = EntityHistory.addHistory(forEntityName: "HighlightActivity", inManageobjectcontext: context)
                                                                                        //                                                                                    print("Create Highlight History")
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                
                                                                            }
                                                                            
                                                })
                                                
                                            }
                                            
                                        }
                                        
                                }
                                    
                                )
                                
                            }
                            
                            do{
                                
                                try context.save()
                                
                            }
                                
                            catch let error {
                                
                                print("Hightlight Data save error with \(error)")
                                completion?(false)
                                
                                return
                                
                            }
                            
                        })
                        
                    }
                
                }
                
                completion?(true)
                
            } else {
                
                completion?(false)
                
            }
            
        }
        
    }
    
    class func downloadActivity(fromActivityId activityId: String, inManageobjectcontext context: NSManagedObjectContext, completion: ((ActivityData?) -> Void)?) {
          
        Alamofire.request("http://staff.chulaexpo.com/api/activities/\(activityId)").responseJSON { (response) in
        
            if response.result.isSuccess {
        
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                let JSON = response.result.value as! NSDictionary
                
                let success = JSON["success"] as! Bool
                
                if !success {
                    
                    print("Can't load activity")
                    completion?(nil)
                    
                } else {
                    
                    let result = JSON["results"] as! NSDictionary
                    
                    let location = result["location"] as! NSDictionary
                    
                    let startTime = result["start"] as! String
                    
                    let endTime = result["end"] as! String
                    
                    let pictures = result["pictures"] as? [String] ?? [""]
                    
                    let tags = result["tags"] as! [String]
                    
                    APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                        
                        context.performAndWait {
                            
                            ActivityData.addEventData(
                                
                                activityId: result["_id"] as? String ?? "",
                                name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                room: location["room"] as? String ?? "",
                                place: location["place"] as? String ?? "",
                                latitude: location["latitude"] as? Double ?? 0.0,
                                longitude: location["longitude"] as? Double ?? 0.0,
                                bannerUrl: result["banner"] as? String ?? "",
                                thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                startTime: startTime,
                                endTime: endTime,
                                isHighlight: result["isHighlight"] as? Bool ?? false,
                                video: result["video"] as? String ?? "",
                                pdf: result["pdf"] as? String ?? "",
                                images: pictures,
                                rounds: rounds,
                                tags: tags,
                                faculty: result["zone"] as? String ?? "",
                                inManageobjectcontext: context,
                                completion: { (activityData) in
                                    
                                    if let activityData = activityData {
                                        
                                        completion?(activityData)

                                    } else {
                                        
                                        completion?(nil)
                                        
                                    }
                                    
                            })

                        }
                        
                        do{
                            
                            try context.save()
                            
                        }
                            
                        catch let error {
                            
                            print("ActivityData save error with \(error)")
                            
                            completion?(nil)
                            
                        }
                        
                    })

                }
                
            } else {
                
                completion?(nil)
                
            }
            
        }
        
    }
    
    class func downloadActivities(fromTagName tag: String, inManageObjectContext context: NSManagedObjectContext, completion: ((Bool?) -> Void)?) {
        
        
        var parameters: [String: Any]!
        
        context.performAndWait {
            
            EntityHistory.fetchLastUpdate(forEntityName: "Interested\(tag)", inManageObjectContext: context, completion: { (dateUpdated) in
                
                if let dateUpdated = dateUpdated {
                    
                    parameters = [
                        "tags": tag,
                        "update": ["gte": dateUpdated]
                    ]
                    
                    
                } else {
                    
                    parameters = [
                        "tags": tag,
                    ]
                    
                }
                
            })
            
        }
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                if let JSON = response.result.value as? NSDictionary {
                    
                    if let results = JSON["results"] as? NSArray {
                        print(results)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                        
                        for result in results {
                            
                            let result = result as! NSDictionary
                            
                            let location = result["location"] as! NSDictionary
                            
                            let startTime = result["start"] as! String
                            
                            let endTime = result["end"] as! String
                            
                            let pictures = result["pictures"] as? [String] ?? [""]
                            
                            let tags = result["tags"] as! [String]
                            
                            APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                                
                                context.performAndWait {
                                    
                                    ActivityData.addEventData(
                                        activityId: result["_id"] as? String ?? "",
                                        name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                        desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                        shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                        room: location["room"] as? String ?? "",
                                        place: location["place"] as? String ?? "",
                                        latitude: location["latitude"] as? Double ?? 0.0,
                                        longitude: location["longitude"] as? Double ?? 0.0,
                                        bannerUrl: result["banner"] as? String ?? "",
                                        thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                        startTime: startTime,
                                        endTime: endTime,
                                        isHighlight: result["isHighlight"] as? Bool ?? false,
                                        video: result["video"] as? String ?? "",
                                        pdf: result["pdf"] as? String ?? "",
                                        images: pictures,
                                        rounds: rounds,
                                        tags: tags,
                                        faculty: result["zone"] as? String ?? "",
                                        inManageobjectcontext: context,
                                        completion: nil)
                                    
                                }
                                
                                do{
                                    
                                    try context.save()
                                    
                                }
                                    
                                catch let error {
                                    
                                    print("Activity in Zone Data save error with \(error)")
                                    completion?(false)
                                    
                                    return
                                    
                                }
                                
                            })
                            
                        }
                        
                        context.performAndWait {
                            
                            if EntityHistory.isThereHistory(forEntityName: "Interested\(tag)", inManageobjectcontext: context) {
                                
                                _ = EntityHistory.updateHistory(forEntityName: "Interested\(tag)", inManageobjectcontext: context)
                                //                                                                                    print("Update Recommend History")
                                
                            } else {
                                
                                _ = EntityHistory.addHistory(forEntityName: "Interested\(tag)", inManageobjectcontext: context)
                                //                                                                                    print("Create Recommend History")
                                
                            }
                            
                        }
                        
                        do{
                            
                            try context.save()
                            
                        }
                            
                        catch let error {
                            
                            print("History Data save error with \(error)")
                            completion?(false)
                            
                            return
                            
                        }
                        
                        completion?(true)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    class func downloadActivities(fromZoneID id: String, inManageObjectContext context: NSManagedObjectContext, completion: ((Bool?) -> Void)?) {
        
        
        var parameters: [String: Any]!
        
        context.performAndWait {
            
            EntityHistory.fetchLastUpdate(forEntityName: "Zone\(id)", inManageObjectContext: context, completion: { (dateUpdated) in
                
                if let dateUpdated = dateUpdated {
                    
                    parameters = [
                        "zone": id,
                        "update": ["gte": dateUpdated]
                    ]
                    
                    
                } else {
                    
                    parameters = [
                        "zone": id,
                    ]
                    
                }
                
            })
            
        }
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                if let JSON = response.result.value as? NSDictionary {
                    
                    if let results = JSON["results"] as? NSArray {
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                        
                        for result in results {
                            
                            let result = result as! NSDictionary
                            
                            let location = result["location"] as! NSDictionary
                            
                            let startTime = result["start"] as! String
                            
                            let endTime = result["end"] as! String
                            
                            let pictures = result["pictures"] as? [String] ?? [""]
                            
                            let tags = result["tags"] as! [String]
                            
                            APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                                
                                context.performAndWait {
                                    
                                    ActivityData.addEventData(
                                        activityId: result["_id"] as? String ?? "",
                                        name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                        desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                        shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                        room: location["room"] as? String ?? "",
                                        place: location["place"] as? String ?? "",
                                        latitude: location["latitude"] as? Double ?? 0.0,
                                        longitude: location["longitude"] as? Double ?? 0.0,
                                        bannerUrl: result["banner"] as? String ?? "",
                                        thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                        startTime: startTime,
                                        endTime: endTime,
                                        isHighlight: result["isHighlight"] as? Bool ?? false,
                                        video: result["video"] as? String ?? "",
                                        pdf: result["pdf"] as? String ?? "",
                                        images: pictures,
                                        rounds: rounds,
                                        tags: tags,
                                        faculty: result["zone"] as? String ?? "",
                                        inManageobjectcontext: context,
                                        completion: nil)
                                    
                                }
                                
                                do{
                                    
                                    try context.save()
                                    
                                }
                                    
                                catch let error {
                                    
                                    print("Activity in Zone Data save error with \(error)")
                                    completion?(false)
                                    
                                    return
                                    
                                }
                                
                            })
                            
                        }
                        
                        context.performAndWait {
                            
                            if EntityHistory.isThereHistory(forEntityName: "Zone\(id)", inManageobjectcontext: context) {
                                
                                _ = EntityHistory.updateHistory(forEntityName: "Zone\(id)", inManageobjectcontext: context)
                                //                                                                                    print("Update Recommend History")
                                
                            } else {
                                
                                _ = EntityHistory.addHistory(forEntityName: "Zone\(id)", inManageobjectcontext: context)
                                //                                                                                    print("Create Recommend History")
                                
                            }
                            
                        }
                        
                        do{
                            
                            try context.save()
                            
                        }
                            
                        catch let error {
                            
                            print("History Data save error with \(error)")
                            completion?(false)
                            
                            return
                            
                        }
                        
                        completion?(true)
                        
                    }
                    
                }
                
            }
            
        }
    
    }

    class func downloadActivities(fromZoneShortName name: String, inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool?) -> Void)?) {
    
        ZoneData.fetchId(fromShortName: name, inManageobjectcontext: context) { (zoneId) in
            
            if let zoneId = zoneId {
                
                var parameters: [String: Any]!
                
                context.performAndWait {
                
                    EntityHistory.fetchLastUpdate(forEntityName: "Zone\(name)", inManageObjectContext: context, completion: { (dateUpdated) in
                        
                        if let dateUpdated = dateUpdated {
                            
                            parameters = [
                                "zone": zoneId,
                                "update": ["gte": dateUpdated]
                            ]
                            
                            
                        } else {
                            
                            parameters = [
                                "zone": zoneId,
                            ]
                            
                        }
                        
                    })
                    
                }
                
                Alamofire.request("http://staff.chulaexpo.com/api/activities", method: .get, parameters: parameters).responseJSON { (response) in
                    
                    if response.result.isSuccess {
                        
                        if let JSON = response.result.value as? NSDictionary {
                            
                            if let results = JSON["results"] as? NSArray {
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                                
                                for result in results {
                                    
                                    let result = result as! NSDictionary
                                    
                                    let location = result["location"] as! NSDictionary
                                    
                                    let startTime = result["start"] as! String
                                    
                                    let endTime = result["end"] as! String
                                    
                                    let pictures = result["pictures"] as? [String] ?? [""]
                                    
                                    let tags = result["tags"] as! [String]
                                    
                                    APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                                        
                                        context.performAndWait {
                                            
                                            ActivityData.addEventData(
                                                activityId: result["_id"] as? String ?? "",
                                                name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
                                                desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
                                                shortDesc: (result["shortDescription"] as? NSDictionary)?["th"] as? String ?? "",
                                                room: location["room"] as? String ?? "",
                                                place: location["place"] as? String ?? "",
                                                latitude: location["latitude"] as? Double ?? 0.0,
                                                longitude: location["longitude"] as? Double ?? 0.0,
                                                bannerUrl: result["banner"] as? String ?? "",
                                                thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                                startTime: startTime,
                                                endTime: endTime,
                                                isHighlight: result["isHighlight"] as? Bool ?? false,
                                                video: result["video"] as? String ?? "",
                                                pdf: result["pdf"] as? String ?? "",
                                                images: pictures,
                                                rounds: rounds,
                                                tags: tags,
                                                faculty: result["zone"] as? String ?? "",
                                                inManageobjectcontext: context,
                                                completion: nil)
                                            
                                        }
                                        
                                        do{
                                            
                                            try context.save()
                                            
                                        }
                                            
                                        catch let error {
                                            
                                            print("Activity in Zone Data save error with \(error)")
                                            completion?(false)
                                            
                                            return
                                            
                                        }
                                        
                                    })
                                    
                                }
                                
                                context.performAndWait {
                                    
                                    if EntityHistory.isThereHistory(forEntityName: "Zone\(name)", inManageobjectcontext: context) {
                                        
                                        _ = EntityHistory.updateHistory(forEntityName: "Zone\(name)", inManageobjectcontext: context)
                                        //                                                                                    print("Update Recommend History")
                                        
                                    } else {
                                        
                                        _ = EntityHistory.addHistory(forEntityName: "Zone\(name)", inManageobjectcontext: context)
                                        //                                                                                    print("Create Recommend History")
                                        
                                    }
                                    
                                }
                                
                                do{
                                    
                                    try context.save()
                                    
                                }
                                    
                                catch let error {
                                    
                                    print("History Data save error with \(error)")
                                    completion?(false)
                                    
                                    return
                                    
                                }
                                
                                completion?(true)
                            
                            }
                        
                        }
                    
                    }
                
                }
            
            }
        
        }
    
//        let dateRequestFormatter = DateFormatter()
//        dateRequestFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        dateRequestFormatter.timeZone = TimeZone(secondsFromGMT: 7)
//
//        let currentTime = dateRequestFormatter.string(from: Date())
//        
//        let parameters: [String: Any] = [
//            "zone": true,
//            "start": [
//                "gte": currentTime,
//            ],
//            "limit": 10
//        ]
        
    }
    
//    class func downloadActivities(inManageobjectcontext context: NSManagedObjectContext) {
//        
//        Alamofire.request("http://staff.chulaexpo.com/api/activities").responseJSON { (response) in
//            
//            if response.result.isSuccess {
//                
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//                
//                let JSON = response.result.value as! NSDictionary
//                let results = JSON["results"] as! NSArray
//                
//                //                print(results)
//                
//                for result in results {
//                    
//                    let result = result as! NSDictionary
//                    
//                    let location = result["location"] as! NSDictionary
//                    
//                    let startTime = result["start"] as! String
//                    
//                    let endTime = result["end"] as! String
//                    
//                    let pictures = result["pictures"] as? [String] ?? [""]
//                    
//                    let tags = result["tags"] as! [String]
//                    
//                    APIController.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
//                        
//                        context.performAndWait {
//                            
//                            _ = ActivityData.addEventData(
//                                
//                                activityId: result["_id"] as? String ?? "",
//                                name: (result["name"] as? NSDictionary)?["th"] as? String ?? "",
//                                desc: (result["description"] as? NSDictionary)?["th"] as? String ?? "",
//                                room: location["room"] as? String ?? "",
//                                place: location["place"] as? String ?? "",
//                                latitude: location["latitude"] as? Double ?? 0.0,
//                                longitude: location["longitude"] as? Double ?? 0.0,
//                                bannerUrl: result["banner"] as? String ?? "",
//                                thumbnailsUrl: result["thumbnail"] as? String ?? "",
//                                startTime: dateFormatter.date(from: startTime) ?? Date(),
//                                endTime: dateFormatter.date(from: endTime) ?? Date(),
//                                isHighlight: result["isHighlight"] as? Bool ?? false,
//                                video: result["video"] as? String ?? "",
//                                pdf: result["pdf"] as? String ?? "",
//                                images: pictures,
//                                rounds: rounds,
//                                tags: tags,
//                                faculty: result["zone"] as? String ?? "",
//                                inManageobjectcontext: context
//                            )
//                        }
//                    })
//                    
//                }
//                
//                do{
//                    
//                    try context.save()
//                    print("ActivityData Saved")
//                    
//                }
//                    
//                catch let error {
//                    
//                    print("ActivityData save error with \(error)")
//                    
//                }
//                
//            }
//            
//        }
//        
//    }
    
    class func downloadZone(inManageobjectcontext context: NSManagedObjectContext) {
        
        var parameters: [String: Any]!
        
        context.performAndWait {
            
            EntityHistory.fetchLastUpdate(forEntityName: "Zone", inManageObjectContext: context, completion: { (dateUpdated) in
                
                if let dateUpdated = dateUpdated {
                    
                    parameters = [
                        
                        "update": ["gte": dateUpdated]
                        
                    ]
                    
                    
                } else {
                    
                    parameters = [:]
                    
                }
                
            })
            
        }
        
        Alamofire.request("http://staff.chulaexpo.com/api/zones", method: .get, parameters: parameters).responseJSON { (response) in
            
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
                        
                        ZoneData.addData(id: result["_id"] as! String,
                                         type: result["type"] as! String,
                                         shortName: shortName["en"] as? String ?? "",
                                         shortNameTh: shortName["th"] as? String ?? "",
                                         banner: result["banner"] as? String ?? "",
                                         thumbnail: result["thumbnail"] as? String ?? "",
                                         desc: desc["en"] as? String ?? "",
                                         descTh: desc["th"] as? String ?? "",
                                         longitude: location["longitude"] as! Double,
                                         latitude: location["latitude"] as! Double,
                                         name: name["en"] as! String,
                                         nameTh: name["th"] as! String,
                                         welcomeMessage: welcomeMsg["th"] as? String ?? "",
                                         inManageobjectcontext: context,
                                         completion: { (zoneData) in
                                            
                                            if zoneData != nil {
                                                
                                                context.performAndWait {
                                                    
                                                    if EntityHistory.isThereHistory(forEntityName: "Zone", inManageobjectcontext: context) {
                                                        
                                                        _ = EntityHistory.updateHistory(forEntityName: "Zone", inManageobjectcontext: context)
                                                        //                                                                                    print("Update Recommend History")
                                                        
                                                    } else {
                                                        
                                                        _ = EntityHistory.addHistory(forEntityName: "Zone", inManageobjectcontext: context)
                                                        //                                                                                    print("Create Recommend History")
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                        })
                        
                    }
                    
                    do{
                        
                        try context.save()
//                        print("ZoneData Saved")
                        
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
        
        var parameters: [String: Any]!
        
        context.performAndWait {
            
            EntityHistory.fetchLastUpdate(forEntityName: "Place", inManageObjectContext: context, completion: { (dateUpdated) in
                
                if let dateUpdated = dateUpdated {
                    
                    parameters = [
                        
                        "update": ["gte": dateUpdated]
                        
                    ]
                    
                    
                } else {
                    
                    parameters = [:]
                    
                }
                
            })
            
        }
        
        Alamofire.request("http://staff.chulaexpo.com/api/places", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    
                    let location = result["location"] as! NSDictionary
                    
                    context.performAndWait {
                        
                        
                        PlaceData.addData(id: result["_id"] as! String,
                                          code: result["code"] as! String,
                                          nameTh: name["th"] as! String,
                                          nameEn: name["en"] as! String,
                                          longitude: location["longitude"] as! Double,
                                          latitude: location["latitude"] as! Double,
                                          zoneID: result["zone"] as! String,
                                          inManageobjectcontext: context,
                                          completion: { (placeData) in
                                            
                                            if placeData != nil {
                                                
                                                context.performAndWait {
                                                    
                                                    if EntityHistory.isThereHistory(forEntityName: "Place", inManageobjectcontext: context) {
                                                        
                                                        _ = EntityHistory.updateHistory(forEntityName: "Place", inManageobjectcontext: context)
                                                        //                                                                                    print("Update Recommend History")
                                                        
                                                    } else {
                                                        
                                                        _ = EntityHistory.addHistory(forEntityName: "Place", inManageobjectcontext: context)
                                                        //                                                                                    print("Create Recommend History")
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                        })
                        
                    }
                    
                    do {
                        
                        try context.save()
//                        print("PlaceData Saved")
                        
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
        
        var parameters: [String: Any]!
        
        context.performAndWait {
            
            EntityHistory.fetchLastUpdate(forEntityName: "Room", inManageObjectContext: context, completion: { (dateUpdated) in
                
                if let dateUpdated = dateUpdated {
                    
                    parameters = [
                        
                        "update": ["gte": dateUpdated]
                        
                    ]
                    
                    
                } else {
                    
                    parameters = [:]
                    
                }
                
            })
            
        }
        
        Alamofire.request("http://staff.chulaexpo.com/api/rooms", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    
                    context.performAndWait {
                        
                        RoomData.addData(id: result["_id"] as! String,
                                         floor: result["floor"] as! String,
                                         name: name["th"] as! String,
                                         placeID: result["place"] as! String,
                                         inManageobjectcontext: context,
                                         completion: { (roomData) in
                                            
                                            if roomData != nil {
                                                
                                                context.performAndWait {
                                                    
                                                    if EntityHistory.isThereHistory(forEntityName: "Room", inManageobjectcontext: context) {
                                                        
                                                        _ = EntityHistory.updateHistory(forEntityName: "Room", inManageobjectcontext: context)
                                                        //                                                                                    print("Update Recommend History")
                                                        
                                                    } else {
                                                        
                                                        _ = EntityHistory.addHistory(forEntityName: "Room", inManageobjectcontext: context)
                                                        //                                                                                    print("Create Recommend History")
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                        })
                        
                    }
                    
                    do{
                        
                        try context.save()
//                        print("RoomData Saved")
                        
                    }
                        
                    catch let error {
                        
                        print("RoomData save error with \(error)")
                        
                    }
                    
                }
                
            }
            
        }
        
    }

    
    class func downloadFacility(inManageobjectcontext context: NSManagedObjectContext) {
        
        var parameters: [String: Any]!
        
        context.performAndWait {
            
            EntityHistory.fetchLastUpdate(forEntityName: "Facility", inManageObjectContext: context, completion: { (dateUpdated) in
                
                if let dateUpdated = dateUpdated {
                    
                    parameters = [
                        
                        "update": ["gte": dateUpdated]
                        
                    ]
                    
                    
                } else {
                    
                    parameters = [:]
                    
                }
                
            })
            
        }
        
        Alamofire.request("http://staff.chulaexpo.com/api/facilities", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    let desc = result["description"] as! NSDictionary
                    let location = result["location"] as! NSDictionary
                    
                    context.performAndWait {
                        
                        FacilityData.addData(id: result["_id"] as! String,
                                             nameTh: name["th"] as! String,
                                             nameEn: name["en"] as! String,
                                             descTh: desc["th"] as! String,
                                             descEn: desc["en"] as! String,
                                             type: result["type"] as! String,
                                             latitude: location["latitude"] as! Double,
                                             longitude: location["longitude"] as! Double,
                                             placeID: result["place"] as! String,
                                             inManageobjectcontext: context,
                                             completion: { (facilityData) in
                                                
                                                if facilityData != nil {
                                                    
                                                    context.performAndWait {
                                                        
                                                        if EntityHistory.isThereHistory(forEntityName: "Facility", inManageobjectcontext: context) {
                                                            
                                                            _ = EntityHistory.updateHistory(forEntityName: "Facility", inManageobjectcontext: context)
                                                            //                                                                                    print("Update Recommend History")
                                                            
                                                        } else {
                                                            
                                                            _ = EntityHistory.addHistory(forEntityName: "Facility", inManageobjectcontext: context)
                                                            //                                                                                    print("Create Recommend History")
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                        })
                        
                    }
                    
                    do{
                        
                        try context.save()
//                        print("FacilityData Saved")
                        
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
            
            let parameters: [String: Any] = ["fields": "activityId"]
            
            Alamofire.request("http://staff.chulaexpo.com/api/me/reserved_rounds", method: .get, parameters: parameters, headers: header).responseJSON(completionHandler: { (response) in
                
                if response.result.isSuccess {
        
                    if let JSON = response.result.value as? NSDictionary {

                        if let results = JSON["results"] as? NSArray {
        
                            context.performAndWait {
                                
                                for result in results {

                                    let result = result as! NSDictionary
                                    
                                    context.performAndWait {
                                        
                                        APIController.downloadActivity(fromActivityId: result["activityId"] as! String, inManageobjectcontext: context, completion: { (activityData) in
                                            
                                            if let activityData = activityData {
                                                
                                                context.performAndWait {
                                                    
                                                    ReservedActivity.addData(activityId: result["activityId"] as! String, roundId: result["_id"] as! String, activityData: activityData, inManageobjectcontext: context, completion: nil)
                                                    
                                                }
                                                
                                            }
                                            
                                        })
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            do{
                                
                                try context.save()
//                                print("Reserved Activity Saved")
                                
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
