//
//  FacilityData+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 2/19/2560 BE.
//
//

import Foundation
import CoreData

@objc(FacilityData)
public class FacilityData: NSManagedObject {

    class func addData(
        id: String,
        nameTh: String,
        nameEn: String,
        descTh: String,
        descEn: String,
        type: String,
        latitude: Double,
        longitude: Double,
        placeID: String,
        inManageobjectcontext context: NSManagedObjectContext,
        completion: ((FacilityData?) -> Void)?
        )
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FacilityData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let facilityData = (try? context.fetch(request))?.first as? FacilityData {
            
            // found this event in the database, return it ...
//            print("Found facility \(result.nameEn)")
                // created a new event in the database
            facilityData.id = id
            facilityData.nameTh = nameTh
            facilityData.nameEn = nameEn
            facilityData.descTh = descTh
            facilityData.descEn = descEn
            facilityData.type = type
            facilityData.latitude = latitude
            facilityData.longitude = longitude
            
            let placeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
            placeRequest.predicate = NSPredicate(format: "id = %@", placeID)
            
            if let result = (try? context.fetch(placeRequest))?.first as? PlaceData {
                // found this event in the database, return it ...
                facilityData.toPlace = result
                
            }
            
            completion?(facilityData)
            
        } else {
            
            if let facilityData = NSEntityDescription.insertNewObject(forEntityName: "FacilityData", into: context) as? FacilityData {
                // created a new event in the database
                facilityData.id = id
                facilityData.nameTh = nameTh
                facilityData.nameEn = nameEn
                facilityData.descTh = descTh
                facilityData.descEn = descEn
                facilityData.type = type
                facilityData.latitude = latitude
                facilityData.longitude = longitude
                
                let placeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
                placeRequest.predicate = NSPredicate(format: "id = %@", placeID)
                
                if let result = (try? context.fetch(placeRequest))?.first as? PlaceData {
                    // found this event in the database, return it ...
                    facilityData.toPlace = result
                    
                }
                
                completion?(facilityData)
                
            } else {
                
                completion?(nil)
            }
            
        }
        
    }
    
    class func fetchFacility(inManageobjectcontext context: NSManagedObjectContext) -> [[String: String]]?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FacilityData")
        
        do {
            
            let facilities = try context.fetch(request) as! [FacilityData]
            
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

//    class func fetchFacilityLocation(inManageobjectcontext context: NSManagedObjectContext) -> [[String: String]]?{
//        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FacilityData")
//        
//        do {
//            
//            let results = try context.fetch(request) as? [FacilityData]
//            
//            var locations = [[String: String]]()
//            
//            for result in results! {
//                
//                locations.append(["latitude": String(result.latitude),
//                                  "longitude": String(result.longitude),
//                                  "id": result.id!,
//                                  "nameEn": result.nameEn!,
//                                  "nameTh": result.nameTh!,
//                                  "shortName": result.shortName!])
//                
//            }
//            
//            return locations
//            
//        } catch {
//            
//            print("Couldn't fetch results")
//            
//        }
//        
//        return nil
//        
//    }
    

}
