//
//  HighlightActivity+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 2/24/2560 BE.
//
//

import Foundation
import CoreData

@objc(HighlightActivity)
public class HighlightActivity: NSManagedObject {
    
    class func addData(activityId: String, inManageobjectcontext context: NSManagedObjectContext) -> Bool? {
        
        let highlightRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
        highlightRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(highlightRequest))?.first as? HighlightActivity {
            
            // found this event in the database, return it ...
            print("Found \(result.activityId!) in HighlightActivity")
            
            return false
            
        }
        
        if let highlightData = NSEntityDescription.insertNewObject(forEntityName: "HighlightActivity", into: context) as? HighlightActivity
        {
            
            // created a new event in the database
            highlightData.activityId = activityId
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@", activityId)
            
            let activityResult = try? context.fetch(activityRequest)
            
            if (activityResult?.count)! > 0 {
            
                print("found an highlight activity")
                
                if let activityResult = activityResult?.first as? ActivityData {
                    
                    highlightData.toActivity = activityResult
                    
                }
                
            } else {
                
                print("download new highlight activity")
                
                APIController.downloadActivity(fromActivityId: activityId, inManageobjectcontext: context, completion: { (activityData) in
                    
                    if activityData != nil {
                        
                        highlightData.toActivity = activityData
                        print("make a highlight relation to new activity data")
                        
                    }
                    
                })
                
            }
            
            if highlightData.toActivity == nil {
                
                return false
                
            }
            
            return true
            
        } else {
            
            print("can't insert highlight new object")
            
            return false
            
        }
        
    }

}
