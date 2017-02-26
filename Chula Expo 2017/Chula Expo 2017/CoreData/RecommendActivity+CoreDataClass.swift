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
    
    class func fetchRecommendActivities(inManageobjectcontext context: NSManagedObjectContext) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        
        do {
            
            let results = try context.fetch(request) as? [RecommendActivity]
            
            for result in results! {
                
                print(result.toActivity)
                
            }
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
    }
    
    class func makeRelation(activityId: String, inManageObjectContext context: NSManagedObjectContext) -> Bool? {
        
        let recommendRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        recommendRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let recommendResult = (try? context.fetch(recommendRequest))?.first as? RecommendActivity {
            
            // found this event in the database, return it ...
//            print("Found \(recommendResult.activityId!) in RecommendActivity")
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
            
            if let activityResult = (try? context.fetch(activityRequest))?.first as? ActivityData
            {
                
                recommendResult.toActivity = activityResult
                
//                print("already make relationship btw recommend and activity")
                return true
                
            }
            
        }
        
        print("fail to make relationship btw recommend and activity")
        
        return false
        
    }
    
    class func addData(activityId: String, activityData: ActivityData, inManageobjectcontext context: NSManagedObjectContext, completion: ((RecommendActivity?) -> Void)?) {
        
        let recommendRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        recommendRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(recommendRequest))?.first as? RecommendActivity {
            
            // found this event in the database, return it ...
//            print("Found \(result.activityId!) in RecommendActivity")
            completion?(result)
            
        } else {
            
            if let recommendData = NSEntityDescription.insertNewObject(forEntityName: "RecommendActivity", into: context) as? RecommendActivity
            {
                        
                recommendData.activityId = activityId
                recommendData.toActivity = activityData
                
                completion?(recommendData)
                
            } else {
                
                print("fail to add new recommend")
                completion?(nil)
                
            }

        }
        
    }
    
}
