//
//  FacilityData+CoreDataProperties.swift
//  
//
//  Created by Pakpoom on 2/19/2560 BE.
//
//

import Foundation
import CoreData


extension FacilityData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FacilityData> {
        return NSFetchRequest<FacilityData>(entityName: "FacilityData");
    }

    @NSManaged public var id: String?
    @NSManaged public var type: String?
    @NSManaged public var nameTh: String?
    @NSManaged public var nameEn: String?
    @NSManaged public var descTh: String?
    @NSManaged public var descEn: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var toPlace: PlaceData?

}
