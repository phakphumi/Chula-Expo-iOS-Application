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
import Siren
import Fabric
import Answers

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SirenDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("...")
        print(urls[urls.count-1] as URL)
        
        Fabric.with([Answers.self])
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        NSTimeZone.default = TimeZone(secondsFromGMT: 25200)!
        
        let siren = Siren.sharedInstance
        siren.delegate = self
        siren.alertType = .force
        siren.checkVersion(checkType: .immediately)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        
        return true
    }
    
    func sirenLatestVersionInstalled() {
        
        let fetchUserData = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        let requestDeleteUserData = NSBatchDeleteRequest(fetchRequest: fetchUserData)
        
        let fetchReservedData = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
        let requestDeleteReservedActivity = NSBatchDeleteRequest(fetchRequest: fetchReservedData)
        
        do {
            
            try managedObjectContext.execute(requestDeleteUserData)
            try managedObjectContext.execute(requestDeleteReservedActivity)
            
        } catch let error {
            
            print(error)
            
        }
        
        if EntityHistory.getLanguage(inManageobjectcontext: managedObjectContext) == nil {
            
            _ = EntityHistory.addHistory(forEntityName: "LANGUAGE-TH", inManageobjectcontext: managedObjectContext)
            
            do {
                
                try managedObjectContext.save()
                
            } catch {
                
                print("error")
                
            }
            
        }
        
        APIController.downloadHightlightActivities(inManageobjectcontext: self.managedObjectContext) { (success) in
            
            if success {
                
                APIController.downloadStageActivities(inManageobjectcontext: self.managedObjectContext, completion: nil)
                
            }
            
        }
        
        APIController.downloadZone(inManageobjectcontext: self.managedObjectContext)
        APIController.downloadFacility(inManageobjectcontext: self.managedObjectContext)
        
    }
    
    func sirenDidShowUpdateDialog(alertType: SirenAlertType) {
        
        self.managedObjectContext.performAndWait {
            
            let fetchActivityData = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            let requestDeleteActivityData = NSBatchDeleteRequest(fetchRequest: fetchActivityData)
            
            let fetchEntityHistory = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityHistory")
            let requestDeleteEntitiyHistory = NSBatchDeleteRequest(fetchRequest: fetchEntityHistory)
            
            let fetchFacilityData = NSFetchRequest<NSFetchRequestResult>(entityName: "FacilityData")
            let requestDeleteFacilityData = NSBatchDeleteRequest(fetchRequest: fetchFacilityData)
            
            let fetchFavoritedData = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedActivity")
            let requestDeleteFavoritedActivity = NSBatchDeleteRequest(fetchRequest: fetchFavoritedData)
            
            let fetchHighlighActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
            let requestDeleteHighlightActivity = NSBatchDeleteRequest(fetchRequest: fetchHighlighActivity)
            
            let fetchImageData = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageData")
            let requestDeleteImageData = NSBatchDeleteRequest(fetchRequest: fetchImageData)
            
            let fetchNearbyActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "NearbyActivity")
            let requestDeleteNearbyActivity = NSBatchDeleteRequest(fetchRequest: fetchNearbyActivity)
            
            let fetchPlaceData = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
            let requestDeletePlaceData = NSBatchDeleteRequest(fetchRequest: fetchPlaceData)
            
            let fetchRecommendActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
            let requestDeleteRecommendActivity = NSBatchDeleteRequest(fetchRequest: fetchRecommendActivity)
            
            let fetchReservedData = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
            let requestDeleteReservedActivity = NSBatchDeleteRequest(fetchRequest: fetchReservedData)
            
            let fetchRoomData = NSFetchRequest<NSFetchRequestResult>(entityName: "RoomData")
            let requestDeleteRoomData = NSBatchDeleteRequest(fetchRequest: fetchRoomData)
            
            let fetchRoundData = NSFetchRequest<NSFetchRequestResult>(entityName: "RoundData")
            let requestDeleteRoundData = NSBatchDeleteRequest(fetchRequest: fetchRoundData)
            
            let fetchStageActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "StageActivity")
            let requestDeleteStageActivity = NSBatchDeleteRequest(fetchRequest: fetchStageActivity)
            
            let fetchTagData = NSFetchRequest<NSFetchRequestResult>(entityName: "TagData")
            let requestDeleteTagData = NSBatchDeleteRequest(fetchRequest: fetchTagData)
            
            let fetchVideoData = NSFetchRequest<NSFetchRequestResult>(entityName: "VideoData")
            let requestDeleteVideoData = NSBatchDeleteRequest(fetchRequest: fetchVideoData)
            
            let fetchZoneData = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
            let requestDeleteZoneData = NSBatchDeleteRequest(fetchRequest: fetchZoneData)
            
            
            let fetchUserData = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            let requestDeleteUserData = NSBatchDeleteRequest(fetchRequest: fetchUserData)
            
            do {
                
                try self.managedObjectContext.execute(requestDeleteActivityData)
                try self.managedObjectContext.execute(requestDeleteEntitiyHistory)
                try self.managedObjectContext.execute(requestDeleteFacilityData)
                try self.managedObjectContext.execute(requestDeleteFavoritedActivity)
                try self.managedObjectContext.execute(requestDeleteHighlightActivity)
                try self.managedObjectContext.execute(requestDeleteImageData)
                try self.managedObjectContext.execute(requestDeleteNearbyActivity)
                try self.managedObjectContext.execute(requestDeletePlaceData)
                try self.managedObjectContext.execute(requestDeleteRecommendActivity)
                try self.managedObjectContext.execute(requestDeleteReservedActivity)
                try self.managedObjectContext.execute(requestDeleteRoomData)
                try self.managedObjectContext.execute(requestDeleteRoundData)
                try self.managedObjectContext.execute(requestDeleteStageActivity)
                try self.managedObjectContext.execute(requestDeleteTagData)
                try self.managedObjectContext.execute(requestDeleteVideoData)
                try self.managedObjectContext.execute(requestDeleteZoneData)
                try self.managedObjectContext.execute(requestDeleteUserData)
                
            } catch let error {
                
                print(error)
                
            }
            
        }
        
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
    
}

