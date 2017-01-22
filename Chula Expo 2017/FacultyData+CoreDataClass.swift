//
//  FacultyData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/22/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(FacultyData)
public class FacultyData: NSManagedObject {
    
    class func addData(
        name: String,
        shortName: String,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> FacultyData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FacultyData")
        request.predicate = NSPredicate(format: "name = %@", name)
        
        if let result = (try? context.fetch(request))?.first as? FacultyData
        {
            // found this event in the database, return it ...
            print("Found \(result.name)")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "FacultyData", into: context) as? FacultyData
            {
                // created a new event in the database
                newData.name = name
                newData.shortName = shortName
                return newData
            }
        }
        return nil
    }

}
