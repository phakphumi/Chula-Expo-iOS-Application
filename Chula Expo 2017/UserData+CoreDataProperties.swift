//
//  UserData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/11/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData");
    }

    @NSManaged public var token: String?
    @NSManaged public var name: String?
    @NSManaged public var userType: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: Int16
    @NSManaged public var pictureUrl: String?
    @NSManaged public var school: String?
    @NSManaged public var company: String?
    @NSManaged public var position: String?
    @NSManaged public var year: Int16

}
