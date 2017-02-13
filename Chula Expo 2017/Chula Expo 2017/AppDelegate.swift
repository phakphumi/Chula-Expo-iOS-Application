//
//  AppDelegate.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/25/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        downloadActivities()
        downloadZone()
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print("...")
        print(urls[urls.count-1] as URL)
        
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.cadiridris.coreDataTemplate" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
         //   abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    private func getRoundsData(activityID: String, completion: @escaping (NSArray) -> Void) {
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities/\(activityID)/rounds").responseJSON { (response) in
            
            let JSON = response.result.value as! NSDictionary
            let results = JSON["results"] as! NSArray
            
            completion(results)
            
        }
        
    }
    
    private func downloadActivities() {
        
        Alamofire.request("http://staff.chulaexpo.com/api/activities").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let context = self.managedObjectContext
        
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
            
                for result in results {
                
                    let result = result as! NSDictionary
                
                    let location = result["location"] as! NSDictionary
                
                    let startTime = result["start"] as! String
                    let endTime = result["end"] as! String
                
                    let pictures = result["pictures"] as? [String] ?? [""]
                
                    let tags = result["tags"] as! [String]
                
                    self.getRoundsData(activityID: result["_id"] as! String, completion: { (rounds) in
                    
                        context.performAndWait {
                        
                            _ = ActivityData.addEventData(activityId: result["_id"] as! String,
                                                          name: (result["name"] as! NSDictionary)["th"] as! String,
                                                          desc: (result["description"] as! NSDictionary)["th"] as! String,
                                                          room: location["room"] as? String ?? "",
                                                          place: location["place"] as! String,
                                                          latitude: location["latitude"] as! Double,
                                                          longitude: location["longitude"] as! Double,
                                                          bannerUrl: result["banner"] as? String ?? "",
                                                          thumbnailsUrl: result["thumbnail"] as? String ?? "",
                                                          startTime: dateFormatter.date(from: startTime)!,
                                                          endTime: dateFormatter.date(from: endTime)!,
                                                          isFavorite: false,
                                                          isHighlight: result["isHighlight"] as? Bool ?? false,
                                                          reservable: false,
                                                          fullCapacity: 110,
                                                          reserved: 10,
                                                          seatAvaliable: 100,
                                                          isReserve: false,
                                                          video: result["video"] as? String ?? "",
                                                          images: pictures,
                                                          rounds: rounds,
                                                          tags: tags,
                                                          faculty: result["zone"] as! String,
                                                          inManageobjectcontext: context)
                        
                        }
                    
                    })
                
                
                }
            
            
            
                do{
                
                    try context.save()
                    print("ActivityData Saved")
                    
                }
                
                catch let error {
                
                    print("ActivityData save error with \(error)")
                    
                }
                
            }
            
        }
        
    }
    
    private func downloadZone() {
        
        Alamofire.request("http://staff.chulaexpo.com/api/zones").responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let context = self.managedObjectContext
                
                let JSON = response.result.value as! NSDictionary
                let results = JSON["results"] as! NSArray
                
                for result in results {
                    
                    let result = result as! NSDictionary
                    
                    let name = result["name"] as! NSDictionary
                    
                    let shortName = result["shortName"] as! NSDictionary
                    
                    let desc = result["description"] as! NSDictionary
                    
                    let location = result["location"] as! NSDictionary
                    
                    let welcomeMsg = result["welcomeMessage"] as! NSDictionary
                    
                    
                    context.performAndWait {
                        
                        _ = ZoneData.addData(id: result["_id"] as! String,
                                             type: result["type"] as! String,
                                             shortName: shortName["en"] as? String ?? "",
                                             desc: desc["en"] as? String ?? "",
                                             longitude: location["longitude"] as! Double,
                                             latitude: location["latitude"] as! Double,
                                             name: name["en"] as! String,
                                             welcomeMessage: welcomeMsg["th"] as? String ?? "",
                                             inManageobjectcontext: context)
                        
                    }
                    
                    do{
                        
                        try context.save()
                        print("ZoneData Saved")
                        
                    }
                        
                    catch let error {
                        
                        print("ZoneData save error with \(error)")
                        
                    }
                    
                }
                
                self.downloadPlace()
                
            }
            
        }
        
    }

    private func downloadPlace() {
        
        Alamofire.request("http://staff.chulaexpo.com/api/places").responseJSON { (response) in
            
            let context = self.managedObjectContext
            
            let JSON = response.result.value as! NSDictionary
            let results = JSON["results"] as! NSArray
            
            for result in results {
                
                let result = result as! NSDictionary
            
                let name = result["name"] as! NSDictionary
            
                let location = result["location"] as! NSDictionary
            
                context.performAndWait {
                
                    _ = PlaceData.addData(id: result["_id"] as! String,
                                          code: result["code"] as! String,
                                          name: name["th"] as! String,
                                          longitude: location["longitude"] as! Double,
                                          latitude: location["latitude"] as! Double,
                                          zoneID: result["zone"] as! String,
                                          inManageobjectcontext: context)
                
                }
            
                do{
                
                    try context.save()
                    print("PlaceData Saved")
                
                }
                
                catch let error {
                
                    print("PlaceData save error with \(error)")
                
                }
            
            }
            
            self.downloadRoom()
        
        }
        
    }
    
    private func downloadRoom() {
        
        Alamofire.request("http://staff.chulaexpo.com/api/rooms").responseJSON { (response) in
            
            let context = self.managedObjectContext
            
            let JSON = response.result.value as! NSDictionary
            let results = JSON["results"] as! NSArray
            
            for result in results {
                
                let result = result as! NSDictionary
            
                let name = result["name"] as! NSDictionary
            
                context.performAndWait {
                
                    _ = RoomData.addData(id: result["_id"] as! String,
                                         floor: result["floor"] as! String,
                                         name: name["th"] as! String,
                                         placeID: result["place"] as! String,
                                         inManageobjectcontext: context)
                
                }
            
                do{
                
                    try context.save()
                    print("RoomData Saved")
                
                }
                
                catch let error {
                
                    print("RoomData save error with \(error)")
                
                }
            
            }
            
        }
        
    }

}

