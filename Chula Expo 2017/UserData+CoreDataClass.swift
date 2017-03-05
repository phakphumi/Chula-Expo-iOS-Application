//
//  UserData+CoreDataClass.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/11/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(UserData)
public class UserData: NSManagedObject {

    class func addUser(
                            id: String,
                            token: String,
                            type: String,
                            name: String,
                            email: String,
                            age: Int,
                            gender: String,
                            school: String?,
                            level: String?,
                            year: String?,
                            job: String?,
                            profile: String?,
                            inManageobjectcontext context: NSManagedObjectContext
                        ) -> UserData?
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.predicate = NSPredicate(format: "token = %@", token)
        request.returnsObjectsAsFaults = false
        
        if let result = (try? context.fetch(request))?.first as? UserData {
            
            // found this event in the database, return it ...
            print("Found \(result.name)")
            result.id = id
            result.token = token
            result.type = type
            result.name = name
            result.email = email
            result.age = Int16(age)
            result.gender = gender
            result.school = school
            result.job = job
            result.year = year
            result.level = level
            result.profile = profile
            
            return result
            
        } else if let newData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context) as? UserData {
            
            // created a new event in the database
            newData.id = id
            newData.token = token
            newData.type = type
            newData.name = name
            newData.email = email
            newData.age = Int16(age)
            newData.gender = gender
            newData.school = school
            newData.job = job
            newData.year = year
            newData.level = level
            newData.profile = profile
            
            return newData
            
        }
        
        return nil
        
    }
    
    class func fetchUser(
                            inManageobjectcontext context: NSManagedObjectContext
        
                        ) -> UserData?
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        do {
            
            let result = try context.fetch(request).first as? UserData
            
            return result
            
        } catch {
    
            print("Couldn't fetch results")
    
        }
        
        return nil
    
    }
    
    class func isThereUser(inManageobjectcontext context: NSManagedObjectContext) -> Bool {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        var count = 0
        
        do {
            
            count = try context.fetch(request).count
            
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
        return count > 0 ? true : false
        
    }

}
