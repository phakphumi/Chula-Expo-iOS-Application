//
//  StageActivity+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 2/24/2560 BE.
//
//

import Foundation
import CoreData

@objc(StageActivity)
public class StageActivity: NSManagedObject {
    
    class func addData(activityId: String, stage: Int, inManageobjectcontext context: NSManagedObjectContext) -> Bool? {
        
        let stageRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StageActivity")
        stageRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(stageRequest))?.first as? StageActivity {
            
            // found this event in the database, return it ...
            print("Found \(result.activityId!) in Stage Activity")
            
            return false
            
        }
        
        if let stageData = NSEntityDescription.insertNewObject(forEntityName: "StageActivity", into: context) as? StageActivity
        {
            
            // created a new event in the database
            stageData.activityId = activityId
            stageData.stage = Int16(stage)
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@", activityId)
            
            let activityResult = try? context.fetch(activityRequest)
            
            if (activityResult?.count)! > 0 {
                
                print("found an stage activity")
                
                if let activityResult = activityResult?.first as? ActivityData {
                    
                    print(activityResult)
                    stageData.toActivity = activityResult
                    
                }
                
            } else {
                
                print("download new stage activity")
                
                APIController.downloadActivity(fromActivityId: activityId, inManageobjectcontext: context, completion: { (activityData) in
                    
                    if activityData != nil {
                        
                        stageData.toActivity = activityData
                        
                    }
                    
                })
                
                print("make a stage relation to new activity data")
                
            }
            
            if stageData.toActivity == nil {
                
                return false
                
            }
            
            return true
            
        } else {
            
            print("can't insert stage new object")
            
            return false
            
        }
        
    }

}
