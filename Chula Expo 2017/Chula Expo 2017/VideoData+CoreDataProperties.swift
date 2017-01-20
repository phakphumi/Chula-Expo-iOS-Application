//
//  VideoData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/20/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData


extension VideoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoData> {
        return NSFetchRequest<VideoData>(entityName: "VideoData");
    }

    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var toActivity: ActivityData?

}
