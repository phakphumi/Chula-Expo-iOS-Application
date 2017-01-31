//
//  FacultyData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData


extension FacultyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FacultyData> {
        return NSFetchRequest<FacultyData>(entityName: "FacultyData");
    }

    @NSManaged public var name: String?
    @NSManaged public var shortName: String?
    @NSManaged public var toActivity: NSSet?

}

// MARK: Generated accessors for toActivity
extension FacultyData {

    @objc(addToActivityObject:)
    @NSManaged public func addToToActivity(_ value: ActivityData)

    @objc(removeToActivityObject:)
    @NSManaged public func removeFromToActivity(_ value: ActivityData)

    @objc(addToActivity:)
    @NSManaged public func addToToActivity(_ values: NSSet)

    @objc(removeToActivity:)
    @NSManaged public func removeFromToActivity(_ values: NSSet)

}
