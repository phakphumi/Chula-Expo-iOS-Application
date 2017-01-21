//
//  TagData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/20/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(TagData)
public class TagData: NSManagedObject {
    
    class func addData(
        name: String,
        toActivity: NSSet,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> TagData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TagData")
        request.predicate = NSPredicate(format: "name = %@", name)
        
        if let result = (try? context.fetch(request))?.first as? TagData
        {
            // found this event in the database, return it ...
            print("Found \(result.name)")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "TagData", into: context) as? TagData
            {
                // created a new event in the database
                newData.name = name
                newData.toActivity = toActivity
                return newData
            }
        }
        return nil
    }


}
