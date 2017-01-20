//
//  ImageData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/20/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(ImageData)
public class ImageData: NSManagedObject {

    class func addData(
        title: String,
        url: String,
        toActivity: ActivityData,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> ImageData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageData")
        request.predicate = NSPredicate(format: "title = %@", title)
        
        if let result = (try? context.fetch(request))?.first as? ImageData
        {
            // found this event in the database, return it ...
            print("Found \(result.title)")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "ImageData", into: context) as? ImageData
            {
                // created a new event in the database
                newData.title = title
                newData.url = url
                newData.toActivity = toActivity
                return newData
            }
        }
        return nil
    }

}
