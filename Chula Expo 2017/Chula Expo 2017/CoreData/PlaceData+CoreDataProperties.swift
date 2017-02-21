//
//  PlaceData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/10/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension PlaceData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceData> {
        return NSFetchRequest<PlaceData>(entityName: "PlaceData");
    }

    @NSManaged public var id: String?
    @NSManaged public var code: String?
    @NSManaged public var nameTh: String?
    @NSManaged public var nameEn: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var toZone: ZoneData?
    @NSManaged public var toRooms: NSSet?
    @NSManaged public var toFacility: NSSet?

}

// MARK: Generated accessors for toRooms
extension PlaceData {

    @objc(addToRoomsObject:)
    @NSManaged public func addToToRooms(_ value: RoomData)

    @objc(removeToRoomsObject:)
    @NSManaged public func removeFromToRooms(_ value: RoomData)

    @objc(addToRooms:)
    @NSManaged public func addToToRooms(_ values: NSSet)

    @objc(removeToRooms:)
    @NSManaged public func removeFromToRooms(_ values: NSSet)

}
