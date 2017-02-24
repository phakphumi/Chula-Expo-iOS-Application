//
//  RecommendActivity+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 2/24/2560 BE.
//
//

import Foundation
import CoreData

@objc(RecommendActivity)
public class RecommendActivity: NSManagedObject {
    
    class func addData(activityId: String, inManageobjectcontext context: NSManagedObjectContext) -> Bool? {
        
        let recommendRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        recommendRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(recommendRequest))?.first as? RecommendActivity {
            
            // found this event in the database, return it ...
            print("Found \(result.activityId!) in RecommendActivity")
            
            return false
            
        }
        
        if let recommendData = NSEntityDescription.insertNewObject(forEntityName: "RecommendActivity", into: context) as? RecommendActivity
        {
            
            // created a new event in the database
            recommendData.activityId = activityId
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@", activityId)
            
            let activityResult = try? context.fetch(activityRequest)
            
            if (activityResult?.count)! > 0 {
                
                print("found an Recommend Activity")
                
                if let activityResult = activityResult?.first as? ActivityData {
                    
                    recommendData.toActivity = activityResult
                    
                }
                
            } else {
                
                print("download new Recommend Activity")
                
                APIController.downloadActivity(fromActivityId: activityId, inManageobjectcontext: context, completion: { (activityData) in
                    
                    if activityData != nil {
                        
                        recommendData.toActivity = activityData
                        print("make a Recommend relation to new activity data")
                        
                    }
                    
                })
                
            }
            
            if recommendData.toActivity == nil {
                
                return false
                
            }
            
            return true
            
        } else {
            
            print("can't insert Recommend Activity new object")
            
            return false
            
        }
        
    }

}
