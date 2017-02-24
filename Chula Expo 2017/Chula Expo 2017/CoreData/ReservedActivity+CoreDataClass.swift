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

    
    class func addData(activityId: String, inManageobjectcontext context: NSManagedObjectContext) -> Bool? {
        
        let reservedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
        reservedRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(reservedRequest))?.first as? ReservedActivity {
            
            // found this event in the database, return it ...
            print("Found \(result.activityId ?? "") in ReservedActivity")
            
            return false
            
        }
        
        if let reservedData = NSEntityDescription.insertNewObject(forEntityName: "ReservedActivity", into: context) as? ReservedActivity
        {
            
            // created a new event in the database
            reservedData.activityId = activityId
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@", activityId)
            
            if let activityResult = try? context.fetch(activityRequest).first as? ActivityData {
                
                reservedData.toActivity = activityResult
                
            } else {
                
                print("can't make a relation to activitydata")
                
                return false
                
            }
            
            return true
            
        } else {
            
            print("can't insert new object")
            
            return false
            
        }
        
    }
    
}
