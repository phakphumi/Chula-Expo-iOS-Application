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
    
    class func addData(activityId: String, roundId: String, inManageobjectcontext context: NSManagedObjectContext, completion: ((Bool) -> Void)?) {
        
        APIController.downloadActivity(fromActivityId: activityId, inManageobjectcontext: context, completion: { (success) in
            
            if success {
                
                if let reservedData = NSEntityDescription.insertNewObject(forEntityName: "ReservedActivity", into: context) as? ReservedActivity
                {
                    
                    reservedData.activityId = activityId
                    reservedData.roundId = roundId
                    
                    print("add an new reserve act")
                    
                    completion?(true)

                    
                    
                } else {
                    
                    print("fail to add new reserv act")
                    completion?(false)
                    
                }

            } else {
                
                print("fail to add new reserve act")
                completion?(false)
                
            }
            
        })
        
    }
    
}
