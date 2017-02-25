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
    
    class func isThereHistory(forEntityName name: String, inManageobjectcontext context: NSManagedObjectContext) -> Bool {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityHistory")
        request.predicate = NSPredicate(format: "name = %@",  name)
        
        if let result = (try? context.fetch(request))?.first as? EntityHistory {
            
            print("There is history for \(result.name)")
            
            return true
            
        }
        
        return false
        
    }
    
    class func updateHistory(forEntityName name: String, inManageobjectcontext context: NSManagedObjectContext) -> EntityHistory? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityHistory")
        request.predicate = NSPredicate(format: "name = %@", name)
        
        if let result = (try? context.fetch(request))?.first as? EntityHistory {
            
            // found this event in the database, return it ...
            print("Found history \(result.name)")
            
            result.dateUpdated = Date()
            
            return result
            
        }
        
        return nil
        
        
    }
    
    class func addHistory(forEntityName name: String, inManageobjectcontext context: NSManagedObjectContext) -> EntityHistory? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityHistory")
        request.predicate = NSPredicate(format: "name = %@", name)
        
        if let result = (try? context.fetch(request))?.first as? EntityHistory {
            
            // found this event in the database, return it ...
            print("Found history \(result.name)")
            
        } else {
            
            if let historyData = NSEntityDescription.insertNewObject(forEntityName: "EntityHistory", into: context) as? EntityHistory {
                // created a new event in the database
                
                historyData.name = name
                historyData.dateCreated = Date()
                historyData.dateUpdated = Date()
               
                return historyData
                
            }
            
        }
        
        return nil
        
    }

}
