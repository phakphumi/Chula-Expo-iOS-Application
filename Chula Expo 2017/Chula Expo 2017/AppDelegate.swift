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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        addDemoData()
        
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
    private func addDemoData(){
        let context = managedObjectContext
            // add demo data
            context.performAndWait {
                _ = ActivityData.addStageEventData(
                    activityId: "001",
                    stageNo: 1,
                    name: "Stage 1 event",
                    desc: "stage 1 desc",
                    startTime: NSDate(),
                    endTime: NSDate(),
                    isFavorite: false,
                    reservable: true,
                    fullCapacity: 100,
                    reserved: 15,
                    seatAvaliable: 17,
                    isReserve: false,
                    inManageobjectcontext: context)
                _ = ActivityData.addStageEventData(
                    activityId: "002",
                    stageNo: 2,
                    name: "Stage 2 event",
                    desc: "stage 2 desc",
                    startTime: NSDate(),
                    endTime: NSDate(),
                    isFavorite: false,
                    reservable: true,
                    fullCapacity: 90,
                    reserved: 1,
                    seatAvaliable: 0,
                    isReserve: false,
                    inManageobjectcontext: context)
                _ = ActivityData.addStageEventData(
                    activityId: "003",
                    stageNo: 3,
                    name: "Stage 3 event",
                    desc: "stage 3 desc",
                    startTime: NSDate(),
                    endTime: NSDate(),
                    isFavorite: false,
                    reservable: true,
                    fullCapacity: 2,
                    reserved: 1,
                    seatAvaliable: 1,
                    isReserve: false,
                    inManageobjectcontext: context)
                _ = ActivityData.addEventData(
                    activityId: "004",
                    name: "event 1 test test",
                    desc: "Hello activity 1 description",
                    locationDesc: "101 Floor 1 ENG 3",
                    bannerUrl: "technology",
                    thumbnailsUrl: "technology",
                    startTime: NSDate(),
                    endTime: NSDate(),
                    isFavorite: false,
                    isHighlight: true,
                    reservable: true,
                    fullCapacity: 20,
                    reserved: 0,
                    seatAvaliable: 20,
                    isReserve: false,
                    toImages: NSSet(object: ImageData.addData(url: "technology", inManageobjectcontext: context)!),
                    toVideos: NSSet(object: VideoData.addData(title: "video 1", url: "youtube url", inManageobjectcontext: context)!),
                    toTags: NSSet(object: TagData.addData(name: "Tech", inManageobjectcontext: context)!),
                    toFaculty: NSSet(object: FacultyData.addData(name: "Faculty of Engineering", shortName: "ENG", inManageobjectcontext: context)!),
                    inManageobjectcontext: context)
                
                _ = ActivityData.addEventData(
                    activityId: "005",
                    name: "Cryonics a new life",
                    desc: "Death occurs when the chemistry of life becomes so disorganized that normal operation cannot be restored. (Death is not when life turns off. People can and have survived being \"turned off\".) How much chemical disorder can be survived depends on medical technology. A hundred years ago, cardiac arrest was irreversible. People were called dead when their heart stopped beating. Today death is believed to occur 4 to 6 minutes after the heart stops beating because after several minutes it is difficult to resuscitate the brain. However, with new experimental treatments, more than 10 minutes of warm cardiac arrest can now be survived without brain injury. Future technologies for molecular repair may extend the frontiers of resuscitation beyond 60 minutes or more, making today's beliefs about when death occurs obsolete. Ultimately, real death occurs when cell structure and chemistry become so disorganized that no technology could restore the original state. This is called the information-theoretic criterion for death. Any other definition of death is arbitrary and subject to continual revision as technology changes. That is certainly the case for death pronounced on the basis of absent \"vital signs\" today, which is not real death at all. The object of cryonics is to prevent death by preserving sufficient cell structure and chemistry so that recovery (including recovery of memory and personality) remains possible by foreseeable technology. If indeed cryonics patients are recoverable in the future, then clearly they were never really dead in the first place. Today's physicians will simply have been wrong about when death occurs, as they have been so many times in the past. The argument that cryonics cannot work because cryonics patients are dead is a circular argument.",
                    locationDesc: "Medicine Building 1000",
                    bannerUrl: "cryonics",
                    thumbnailsUrl: "cryonics",
                    startTime: NSDate(),
                    endTime: NSDate(),
                    isFavorite: false,
                    isHighlight: true,
                    reservable: true,
                    fullCapacity: 55,
                    reserved: 12,
                    seatAvaliable: 13,
                    isReserve: false,
                    toImages: NSSet(objects:
                        ImageData.addData(url: "cryonics1", inManageobjectcontext: context)!,
                                    ImageData.addData(url: "cryonics2", inManageobjectcontext: context)!,
                                    ImageData.addData(url: "cryonics3", inManageobjectcontext: context)!,
                                    ImageData.addData(url: "cryonics4", inManageobjectcontext: context)!,
                                    ImageData.addData(url: "cryonics5", inManageobjectcontext: context)!),
                    toVideos: NSSet(object: VideoData.addData(title: "video 1", url: "youtube url", inManageobjectcontext: context)!),
                    toTags: NSSet(objects: TagData.addData(name: "Technology", inManageobjectcontext: context)!,
                                  TagData.addData(name: "Medicine", inManageobjectcontext: context)!,
                                  TagData.addData(name: "Science", inManageobjectcontext: context)!),
                    toFaculty: NSSet(object: FacultyData.addData(name: "Faculty of Medicine", shortName: "MED", inManageobjectcontext: context)!),
                    inManageobjectcontext: context)
            }
            
            do{
                try managedObjectContext.save()
                print("Demo ActivityData Saved")
            }
                
            catch let error {
                print("Demo ActivityData save error with \(error)")
            }
            
//            printDatabaseStatistics()
        }

}

