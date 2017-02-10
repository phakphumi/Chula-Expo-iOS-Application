//
//  RoomData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/10/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension RoomData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoomData> {
        return NSFetchRequest<RoomData>(entityName: "RoomData");
    }

    @NSManaged public var id: String?
    @NSManaged public var floor: String?
    @NSManaged public var name: String?
    @NSManaged public var toPlace: PlaceData?

}
