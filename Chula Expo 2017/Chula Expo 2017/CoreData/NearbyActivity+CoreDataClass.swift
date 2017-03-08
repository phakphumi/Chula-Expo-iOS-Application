//
//  NearbyActivity+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 3/6/2560 BE.
//
//

import Foundation
import CoreData

@objc(NearbyActivity)
public class NearbyActivity: NSManagedObject {
    
    class func addData(activityId: String, activityData: ActivityData, inManageobjectcontext context: NSManagedObjectContext, completion: ((NearbyActivity?) -> Void)?) {
        
        let nearbyRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NearbyActivity")
        nearbyRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(nearbyRequest))?.first as? NearbyActivity {
            
            // found this event in the database, return it ...
            //            print("Found \(result.activityId!) in RecommendActivity")
            completion?(result)
            
        } else {
            
            if let nearbyData = NSEntityDescription.insertNewObject(forEntityName: "NearbyActivity", into: context) as? NearbyActivity
            {
                
                nearbyData.activityId = activityId
                nearbyData.toActivity = activityData
                
                completion?(nearbyData)
                
            } else {
                
                print("fail to add new nearby")
                completion?(nil)
                
            }
            
        }
        
    }

}
