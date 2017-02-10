//
//  ZoneData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/10/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ZoneData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ZoneData> {
        return NSFetchRequest<ZoneData>(entityName: "ZoneData");
    }

    @NSManaged public var id: String?
    @NSManaged public var type: String?
    @NSManaged public var shortName: String?
    @NSManaged public var desc: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var name: String?
    @NSManaged public var welcomeMessage: String?
    @NSManaged public var toPlaces: NSSet?

}

// MARK: Generated accessors for toPlaces
extension ZoneData {

    @objc(addToPlacesObject:)
    @NSManaged public func addToToPlaces(_ value: PlaceData)

    @objc(removeToPlacesObject:)
    @NSManaged public func removeFromToPlaces(_ value: PlaceData)

    @objc(addToPlaces:)
    @NSManaged public func addToToPlaces(_ values: NSSet)

    @objc(removeToPlaces:)
    @NSManaged public func removeFromToPlaces(_ values: NSSet)

}
