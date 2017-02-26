//
//  ReservedActivity+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 2/23/2560 BE.
//
//

import Foundation
import CoreData

@objc(ReservedActivity)
public class ReservedActivity: NSManagedObject {

    class func fetchReservedActivity(inManageobjectcontext context: NSManagedObjectContext) -> [ReservedActivity]? {
        
        let reservedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
        
        if let reserves = (try? context.fetch(reservedRequest)) as? [ReservedActivity] {
            
            return reserves
            
        }
        
        return nil
        
    }

    class func makeRelation(activityId: String, inManageObjectContext context: NSManagedObjectContext) -> Bool? {
        print(1)
        let reservedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
        reservedRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let reservedResult = (try? context.fetch(reservedRequest))?.first as? ReservedActivity {
            print(2)
            // found this event in the database, return it ...
            //            print("Found \(highlightResult.activityId!) in HighlightActivity")
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
            
            if let activityResult = (try? context.fetch(activityRequest))?.first as? ActivityData
            {
                print(3)
                reservedResult.toActivity = activityResult
                print(reservedResult)
                try? context.save()
                print("already make relationship btw highlight and activity")
                return true
                
            }
            
        }
        
        print("fail to make relationship btw reserve and activity")
        
        return false
        
    }
    
    class func addData(activityId: String, roundId: String, activityData: ActivityData, inManageobjectcontext context: NSManagedObjectContext, completion: ((ReservedActivity?) -> Void)?) {
        
        let reservedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
        reservedRequest.predicate = NSPredicate(format: "activityId = %@ AND roundId = %@", activityId, roundId)
        
        if let result = (try? context.fetch(reservedRequest))?.first as? ReservedActivity {
            
            completion?(result)
            
        } else {
            
            if let reservedData = NSEntityDescription.insertNewObject(forEntityName: "ReservedActivity", into: context) as? ReservedActivity {
                
                reservedData.activityId = activityId
                reservedData.roundId = roundId
                reservedData.toActivity = activityData
                
                completion?(reservedData)
                
            } else {
                
                completion?(nil)
                
            }
            
        }
                
    }
    
}
