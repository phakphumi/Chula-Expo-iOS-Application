//
//  FavoritedActivity+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 2/13/2560 BE.
//
//

import Foundation
import CoreData

@objc(FavoritedActivity)
public class FavoritedActivity: NSManagedObject {
    
    class func addData(activityId: String, inManageobjectcontext context: NSManagedObjectContext) -> Bool? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedActivity")
        request.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(request))?.first as? FavoritedActivity {
            
            // found this event in the database, return it ...
            print("Found \(result.activityId) in FavoriteActivity")
            
            return false
            
        }

        if let favoriteData = NSEntityDescription.insertNewObject(forEntityName: "FavoritedActivity", into: context) as? FavoritedActivity
        {
            
            // created a new event in the database
            favoriteData.activityId = activityId
            
        }
        
        return true
        
    }

}
