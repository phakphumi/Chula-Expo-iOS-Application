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
        nameTh: String,
        nameEn: String,
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
//            print("Found place \(result.nameEn)")
            return result
            
        } else {
            
            if let placeData = NSEntityDescription.insertNewObject(forEntityName: "PlaceData", into: context) as? PlaceData {
                // created a new event in the database
                placeData.id = id
                placeData.code = code
                placeData.nameTh = nameTh
                placeData.nameEn = nameEn
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
    
    class func fetchPlace(InZone id : String, inManageobjectcontext context: NSManagedObjectContext) -> [[String: String]]?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            
            let zoneResults = try context.fetch(request).first as? ZoneData
            
            let places = zoneResults?.toPlaces?.allObjects as! [PlaceData]
            
            var locations = [[String: String]]()
            
            for place in places {
                
                locations.append(["latitude": String(place.latitude),
                                  "longitude": String(place.longitude),
                                  "id": place.id!,
                                  "nameTh": place.nameTh!,
                                  "nameEn": place.nameEn!,
                                  //                                  "nameTh": place.nameTh!,
                    "code": place.code!])
                
            }
            
            return locations
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
        return nil
        
    }
    
    class func fetchFacility(InPlace id : String, inManageobjectcontext context: NSManagedObjectContext) -> [[String: String]]?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            
            let placeResults = try context.fetch(request).first as? PlaceData
            
            let facilities = placeResults?.toFacility?.allObjects as! [FacilityData]
            
            var locations = [[String: String]]()

            for facility in facilities {
                
                locations.append(["latitude": String(facility.latitude),
                                    "longitude": String(facility.longitude),
                                    "id": facility.id!,
                                    "type": facility.type!,
                                    "nameTh": facility.nameTh!,
                                    "nameEn": facility.nameEn!,
                                    "descTh": facility.descTh!,
                                    "descEn": facility.descEn!])
                
            }
            
            return locations
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
        return nil
        
    }
    
    class func getPlaceName(fromPlaceId id: String, inManageobjectcontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let result = (try? context.fetch(request))?.first as? PlaceData {
            
            // found this event in the database, return it ...
            
            return result.nameTh!
            
        }
        
        return ""
        
    }
    
    
}
