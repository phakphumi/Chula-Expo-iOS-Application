//
//  ImageData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData

@objc(ImageData)
public class ImageData: NSManagedObject {

    class func addData(
        url: String,
        activityData: ActivityData,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> ImageData?
    {
        if let imageData = NSEntityDescription.insertNewObject(forEntityName: "ImageData", into: context) as? ImageData
        {
            // created a new event in the database
            imageData.url = url
            imageData.toActivity = activityData
            return imageData
        }
        return nil
    }
}
