//
//  ZoneData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/10/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(ZoneData)
public class ZoneData: NSManagedObject {
    
    class func addData(
        id: String,
        type: String,
        shortName: String,
        shortNameTh: String,
        banner: String,
        thumbnail: String,
        desc: String,
        descTh: String,
        longitude: Double,
        latitude: Double,
        name: String,
        nameTh: String,
        welcomeMessage: String,
        inManageobjectcontext context: NSManagedObjectContext,
        completion: ((ZoneData?) -> Void)?
        )
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let zoneData = (try? context.fetch(request))?.first as? ZoneData {
            // found this event in the database, return it ...
//            print("Found round \(result.name) in id \(result.id)")
            
            zoneData.id = id
            zoneData.type = type
            zoneData.shortName = shortName
            zoneData.shortNameTh = shortNameTh
            zoneData.banner = banner == "" ? "" : "https://staff.chulaexpo.com\(banner)"
            zoneData.thumbnail = thumbnail == "" ? "" : "https://staff.chulaexpo.com\(thumbnail)"
            zoneData.desc = desc
            zoneData.descTh = descTh
            zoneData.longitude = longitude
            zoneData.latitude = latitude
            zoneData.name = name
            zoneData.nameTh = nameTh
            zoneData.welcomeMessage = welcomeMessage
            
            completion?(zoneData)
            
        } else {
            if let zoneData = NSEntityDescription.insertNewObject(forEntityName: "ZoneData", into: context) as? ZoneData
            {
                // created a new event in the database
                zoneData.id = id
                zoneData.type = type
                zoneData.shortName = shortName
                zoneData.shortNameTh = shortNameTh
                zoneData.banner = banner == "" ? "" : "https://staff.chulaexpo.com\(banner)"
                zoneData.thumbnail = thumbnail == "" ? "" : "https://staff.chulaexpo.com\(thumbnail)"
                zoneData.desc = desc
                zoneData.descTh = descTh
                zoneData.longitude = longitude
                zoneData.latitude = latitude
                zoneData.name = name
                zoneData.nameTh = nameTh
                zoneData.welcomeMessage = welcomeMessage
                
                
                completion?(zoneData)
                
            } else {
                
                completion?(nil)
                
            }
            
        }

    }
    
    class func fetchZoneDetail( zoneId: String, inManageobjectcontext context: NSManagedObjectContext ) -> ZoneData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id = %@", zoneId)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result
        } catch {
            print("Couldn't fetch results")
        }
        return nil
    }
    
    class func fetchId(fromShortName name : String, inManageobjectcontext context: NSManagedObjectContext, completion: ((String?) -> Void)?) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "shortName = %@", name)
        
        if let result = (try? context.fetch(request))?.first as? ZoneData {
            
            completion?(result.id)
            
        } else {
            
            completion?(nil)
            
        }
        
    }

    class func fetchIdFrom(name: String, inManageobjectcontext context: NSManagedObjectContext) -> String?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.id
        } catch {
            print("Couldn't fetch results")
        }

        return nil
    }
    

    class func fetchZoneLocation(inManageobjectcontext context: NSManagedObjectContext) -> [[String: String]]?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        
        do {
            
            let results = try context.fetch(request) as? [ZoneData]
            
            var locations = [[String: String]]()
    
            for result in results! {
                
                locations.append(["latitude": String(result.latitude),
                                  "longitude": String(result.longitude),
                                  "id": result.id!,
                                  "nameEn": result.name!,
                                  "nameTh": result.nameTh!,
                                  "shortName": result.shortName!])
                
            }
            
            return locations
            
        } catch {
            
            print("Couldn't fetch results")
            
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
    

    class func fetchTagFrom(name: String, inManageobjectcontext context: NSManagedObjectContext) -> String?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.shortName
        } catch {
            print("Couldn't fetch results")
        }
        
        return nil

    }
    
    class func fetchBackgroundFrom(name: String, inManageobjectcontext context: NSManagedObjectContext) -> String?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.thumbnail
        } catch {
            print("Couldn't fetch results")
        }
        
        return nil
        
    }

    
    class func fetchZoneFromPlace(id: String, incontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "ANY toPlaces.id = %@", id)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.id ?? ""
            
        } catch {
            print("Couldn't fetch results")
        }

        return ""
    }
    
    class func fetchZoneBannerFrom(id: String, incontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.banner ?? ""
            
        } catch {
            print("Couldn't fetch results")
        }
        
        return ""
    }

    class func fetchZoneNameFrom(id: String, incontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.name ?? ""
            
        } catch {
            print("Couldn't fetch results")
        }
        
        return ""
    }
    
    class func fetchZoneDescFrom(id: String, incontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.descTh ?? ""
            
        } catch {
            print("Couldn't fetch results")
        }
        
        return ""
    }
    
    class func fetchZoneWelcomeFrom(id: String, incontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try context.fetch(request).first as? ZoneData
            return result?.welcomeMessage ?? ""
            
        } catch {
            print("Couldn't fetch results")
        }
        
        return ""
    }

    
    class func getZoneName(fromZoneId id: String, inManageobjectcontext context: NSManagedObjectContext) -> String {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let result = (try? context.fetch(request))?.first as? ZoneData {
            
            // found this event in the database, return it ...
            
            return result.nameTh!
            
        }
        
        return ""
        
    }

}
