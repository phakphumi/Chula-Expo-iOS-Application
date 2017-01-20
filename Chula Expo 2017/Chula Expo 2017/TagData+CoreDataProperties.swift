//
//  TagData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/20/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData


extension TagData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagData> {
        return NSFetchRequest<TagData>(entityName: "TagData");
    }

    @NSManaged public var name: String?
    @NSManaged public var toActivity: NSSet?

}

// MARK: Generated accessors for toActivity
extension TagData {

    @objc(addToActivityObject:)
    @NSManaged public func addToToActivity(_ value: ActivityData)

    @objc(removeToActivityObject:)
    @NSManaged public func removeFromToActivity(_ value: ActivityData)

    @objc(addToActivity:)
    @NSManaged public func addToToActivity(_ values: NSSet)

    @objc(removeToActivity:)
    @NSManaged public func removeFromToActivity(_ values: NSSet)

}
