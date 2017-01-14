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
                            token: String,
                            userType: String,
                            name: String,
                            email: String,
                            age: Int,
                            gender: String,
                            school: String,
                            company: String,
                            year: Int,
                            position: String,
                            pictureUrl: String,
                            inManageobjectcontext context: NSManagedObjectContext
                        ) -> UserData?
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.predicate = NSPredicate(format: "token = %@", token)
        request.returnsObjectsAsFaults = false
        
        if let result = (try? context.fetch(request))?.first as? UserData {
            
            // found this event in the database, return it ...
            print("Found \(result.name)")
            return result
            
        } else if let newData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context) as? UserData {
            
            // created a new event in the database
            newData.token = token
            newData.userType = userType
            newData.name = name
            newData.email = email
            newData.age = Int16(age)
            newData.gender = gender
            newData.school = school
            newData.company = company
            newData.year = Int16(year)
            newData.position = position
            newData.pictureUrl = pictureUrl
            
            return newData
            
        }
        
        return nil
        
    }
    
    class func fetchUser(
                            token: String,
                            inManageobjectcontext context: NSManagedObjectContext
        
                        ) -> UserData?
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.predicate = NSPredicate(format: "token = %@", token)
        
        do {
            
            let result = try context.fetch(request).first as? UserData
            
            return result
            
        } catch {
    
            print("Couldn't fetch results")
    
        }
        
        return nil
    
    }
    

}
