//
//  EntityHistory+CoreDataClass.swift
//  
//
//  Created by Pakpoom on 2/23/2560 BE.
//
//

import Foundation
import CoreData

@objc(EntityHistory)
public class EntityHistory: NSManagedObject {
    
//    class func addHistory(forEntityName name: String, inManageobjectcontext context: NSManagedObjectContext) {
//        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityHistory")
//        request.predicate = NSPredicate(format: "name = %@", name)
//        
//        if let result = (try? context.fetch(request))?.first as? EntityHistory {
//            
//            // found this event in the database, return it ...
//            print("Found facility \(result.name)")
//            
//        } else {
//            
//            if let historyData = NSEntityDescription.insertNewObject(forEntityName: "HistoryEntity", into: context) as? EntityHistory {
//                // created a new event in the database
//                
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//                
//                historyData.name = name
//                
//                facilityData.id = id
//                facilityData.nameTh = nameTh
//                facilityData.nameEn = nameEn
//                facilityData.descTh = descTh
//                facilityData.descEn = descEn
//                facilityData.type = type
//                facilityData.latitude = latitude
//                facilityData.longitude = longitude
//                
//                let placeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
//                placeRequest.predicate = NSPredicate(format: "id = %@", placeID)
//                
//                if let result = (try? context.fetch(placeRequest))?.first as? PlaceData {
//                    // found this event in the database, return it ...
//                    facilityData.toPlace = result
//                    
//                }
//                
//                return facilityData
//                
//            }
//            
//        }
//        
//    }

}
