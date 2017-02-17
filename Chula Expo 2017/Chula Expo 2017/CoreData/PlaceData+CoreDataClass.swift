//
//  PlaceData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/10/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(PlaceData)
public class PlaceData: NSManagedObject {

    class func addData(
        id: String,
        code: String,
        name: String,
        longitude: Double,
        latitude: Double,
        zoneID: String,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> PlaceData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let result = (try? context.fetch(request))?.first as? PlaceData {
            
            // found this event in the database, return it ...
            print("Found place \(result.name)")
            return result
            
        } else {
            
            if let placeData = NSEntityDescription.insertNewObject(forEntityName: "PlaceData", into: context) as? PlaceData {
                // created a new event in the database
                placeData.id = id
                placeData.code = code
                placeData.name = name
                placeData.longitude = longitude
                placeData.latitude = latitude
                
                let zoneRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
                zoneRequest.predicate = NSPredicate(format: "id = %@", zoneID)
                
                if let result = (try? context.fetch(zoneRequest))?.first as? ZoneData {
                    // found this event in the database, return it ...
                    placeData.toZone = result
                    
                }
                
                return placeData
                
            }
            
        }
        
        return nil
        
    }   
    
}
