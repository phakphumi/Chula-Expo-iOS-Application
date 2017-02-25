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
    
    class func fetchFavoritedActivity(inManageobjectcontext context: NSManagedObjectContext) -> [FavoritedActivity]? {
        
        let favoriteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedActivity")
        
        if let favourites = (try? context.fetch(favoriteRequest)) as? [FavoritedActivity] {
            
            return favourites
            
        }
        
        return nil
        
    }
    
    class func addData(activityId: String, inManageobjectcontext context: NSManagedObjectContext) -> Bool? {
        
        let favoriteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedActivity")
        favoriteRequest.predicate = NSPredicate(format: "activityId = %@",  activityId)
        
        if let result = (try? context.fetch(favoriteRequest))?.first as? FavoritedActivity {
            
            // found this event in the database, return it ...
//            print("Found \(result.activityId!) in FavoriteActivity")
            
            return false
            
        }

        if let favoriteData = NSEntityDescription.insertNewObject(forEntityName: "FavoritedActivity", into: context) as? FavoritedActivity
        {
            
            // created a new event in the database
            favoriteData.activityId = activityId
            
            let activityRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            activityRequest.predicate = NSPredicate(format: "activityId = %@", activityId)
            
            if let activityResult = try? context.fetch(activityRequest).first as? ActivityData {
                
                favoriteData.toActivity = activityResult
                
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
