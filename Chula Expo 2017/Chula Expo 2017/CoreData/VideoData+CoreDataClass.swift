//
//  VideoData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(VideoData)
public class VideoData: NSManagedObject {
    
    class func addData(
        title: String,
        url: String,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> VideoData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VideoData")
        request.predicate = NSPredicate(format: "title = %@", title)
        
        if let result = (try? context.fetch(request))?.first as? VideoData
        {
            // found this event in the database, return it ...
            print("Found \(result.title)")
            return result
        }
        else {
            if let newData = NSEntityDescription.insertNewObject(forEntityName: "VideoData", into: context) as? VideoData
            {
                // created a new event in the database
                newData.title = title
                newData.url = url
                return newData
            }
        }
        return nil
    }

}
