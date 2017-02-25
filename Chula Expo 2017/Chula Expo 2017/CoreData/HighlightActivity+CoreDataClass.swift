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
    
    class func fetchHighlightActivities(inManageobjectcontext context: NSManagedObjectContext) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
        
        do {
            
            let results = try context.fetch(request) as? [HighlightActivity]
            
            for result in results! {
                
                print(result.toActivity)
                
            }
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
    }
    
    class func makeRelation(activityId: String, inManageObjectContext context: NSManagedObjectContext) -> Bool? {
        
        let highlightRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
        highlightRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let highlightResult = (try? context.fetch(highlightRequest))?.first as? HighlightActivity {
            
            // found this event in the database, return it ...
//            print("Found \(highlightResult.activityId!) in HighlightActivity")
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
            
            if let activityResult = (try? context.fetch(activityRequest))?.first as? ActivityData
            {
                
                highlightResult.toActivity = activityResult
            
//                print("already make relationship btw highlight and activity")
                return true
                
            }
            
        }
        
        print("fail to make relationship btw highlight and activity")
        
        return false
        
    }

    
    class func addData(activityId: String, inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        
        let highlightRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
        highlightRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(highlightRequest))?.first as? HighlightActivity {
            
            // found this event in the database, return it ...
//            print("Found \(result.activityId!) in HighlightActivity")
            completion?(false)
            
        } else {
            
            if let highlightData = NSEntityDescription.insertNewObject(forEntityName: "HighlightActivity", into: context) as? HighlightActivity
            {
                // created a new event in the database
                
                //            print("download new highlight activity")
                APIController.downloadActivity(fromActivityId: activityId, inManageobjectcontext: context, completion: { (success) in
                    
                    if success {
                        
                        highlightData.activityId = activityId
                        
//                        print("add an new highlight activity")
                        
                        completion?(true)
                        
                    } else {
                        
                        print("fail to add new highlight")
                        completion?(false)
                        
                    }
                    
                })
                
            } else {
                
                print("fail to add new highlight")
                completion?(false)
                
            }
            
        }
        
    }

}
