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
        url: String,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> ImageData?
    {
        if let newData = NSEntityDescription.insertNewObject(forEntityName: "ImageData", into: context) as? ImageData
            {
                // created a new event in the database
                newData.url = url
                return newData
            }
        return nil
    }

}
