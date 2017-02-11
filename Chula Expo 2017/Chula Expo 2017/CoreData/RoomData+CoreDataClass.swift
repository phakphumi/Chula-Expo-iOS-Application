//
//  RoomData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/10/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(RoomData)
public class RoomData: NSManagedObject {
    
    class func getLocation(fromRoomId id: String, inManageobjectcontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RoomData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let result = (try? context.fetch(request))?.first as? RoomData {
            
            // found this event in the database, return it ...
            
            let place = "\(result.name!) \((result.toPlace?.name)!) \((result.toPlace?.toZone?.name)!)"
            
            return place
            
        }
        
        return ""
        
    }
    
    class func addData(
        id: String,
        floor: String,
        name: String,
        placeID: String,
        inManageobjectcontext context: NSManagedObjectContext
        ) -> RoomData?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RoomData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let result = (try? context.fetch(request))?.first as? RoomData {
            
            // found this event in the database, return it ...
            print("Found room \(result.name) in  \(result.toPlace?.name)")
            return result
            
        } else {
            
            if let roomData = NSEntityDescription.insertNewObject(forEntityName: "RoomData", into: context) as? RoomData {
                // created a new event in the database
                roomData.id = id
                roomData.floor = floor
                roomData.name = name
                
                let placeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
                placeRequest.predicate = NSPredicate(format: "id = %@", placeID)
                
                if let result = (try? context.fetch(placeRequest))?.first as? PlaceData {
                    
                    // found this event in the database, return it ...
                    roomData.toPlace = result
                    
                }
                
                return roomData
                
            }
            
        }
        
        return nil
        
    }

}
