//
//  FirstViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: MainCoreDataTableViewController {

    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    @IBOutlet var homeTableView: UITableView!
    @IBOutlet var headerSectionView: UIView!
    @IBOutlet var headerSectionView2: UIView!
    @IBOutlet weak var facityCapsule: UILabel!
    @IBOutlet weak var reserveCapsule: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestForStageEvent()
        requestForFeedEvent()
        addDemoData()
        
        
//         Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
//
//         Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        createGradientNavBar()
        homeTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
// Core Data
    func requestForStageEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "isStageEvent = %@", NSNumber(booleanLiteral: true))

        request.sortDescriptors = [NSSortDescriptor(
        key: "stageNo",
        ascending: true
        )]
        
        if let context = managedObjectContext {
            
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        }
    }
    func requestForFeedEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "isStageEvent = %@", NSNumber(booleanLiteral: false))
        request.sortDescriptors = [NSSortDescriptor(
            key: "activityId",
            ascending: true
            )]
        
        if let context = managedObjectContext {
            
            fetchedResultsController2 = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
        }
        
    }
    
    
    @IBAction func qrcode(_ sender: UIBarButtonItem) {
        
        if UserController.loginStatus! {
            
            tabBarController?.performSegue(withIdentifier: "toQRCodeVC", sender: tabBarController)
            
        } else {
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ฟังก์ชั่นนี้สนับสนุนเฉพาะผู้เข้าระบบผ่าน Facebook เท่านั้น", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Slideshow", for: indexPath)
            cell.selectionStyle = .none
            
            let slideshowPageViewController = SlideshowPageViewController()
            slideshowPageViewController.view.transform = CGAffineTransform(scaleX: cell.bounds.width / 375, y: cell.bounds.height / 220)
            slideshowPageViewController.view.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            self.addChildViewController(slideshowPageViewController)
            
            cell.contentView.addSubview(slideshowPageViewController.view)
    
        }
            
        else if indexPath.section == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "Stage", for: indexPath)
                if let fetchData = fetchedResultsController?.object(at: IndexPath(row: indexPath.row, section: 0)) as? ActivityData
                {
                    var name: String?
                    var startTime: NSDate?
                    var endTime: NSDate?
                    var stage: Int?
                fetchData.managedObjectContext?.performAndWait                {
                    // it's easy to forget to do this on the proper queue
                    name = fetchData.name
                    startTime = fetchData.startTime
                    endTime = fetchData.endTime
                    stage = Int(fetchData.stageNo)
                    // we're not assuming the context is a main queue context
                    // so we'll grab the screenName and return to the main queue
                    // to do the cell.textLabel?.text setting
                   }
                if let stageCell = cell as? StageCell{
                    stageCell.name = name
                    stageCell.startTime = startTime
                    stageCell.endTime = endTime
                    stageCell.stage = stage
                }
                let seperator = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 3))
                seperator.backgroundColor = UIColor.clear
                cell.contentView.addSubview(seperator)
            }
        }
        else{
            print("section else")
            cell = tableView.dequeueReusableCell(withIdentifier: "EventFeed", for: indexPath)
            if let fetchData = fetchedResultsController2?.object(at: IndexPath(row: indexPath.row, section: 0)) as? ActivityData{
                var name: String?
                var startTime: NSDate?
                var endTime: NSDate?
                var thumbnail: String?
                var facity: String?
                var date: String?
                fetchData.managedObjectContext?.performAndWait{
                    // it's easy to forget to do this on the proper queue
                    name = fetchData.name
                    startTime = fetchData.startTime
                    endTime = fetchData.endTime
                    thumbnail = fetchData.thumbnailsUrl
                    let fac = fetchData.toFaculty?.allObjects.first as! FacultyData
                    facity = fac.shortName
                    date = fetchData.dateText
                    // we're not assuming the context is a main queue context
                    // so we'll grab the screenName and return to the main queue
                    // to do the cell.textLabel?.text setting
                }
                print("feedCell name == \(name)")
                if let eventFeedCell = cell as? EventFeedCell{
                    print("feedCell name == \(name)")
                    eventFeedCell.name = name
                    eventFeedCell.startTime = startTime
                    eventFeedCell.endTime = endTime
                    eventFeedCell.thumbnail = thumbnail
                    eventFeedCell.facity = facity
                    eventFeedCell.date = date
                }
            }
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return headerSectionView
        }
        else if section == 2 {
            return headerSectionView2
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 50
        }
        return 0
        
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 1{
            return 8
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 && indexPath.section == 0 {
            return self.view.bounds.width * 218 / 375
        }
        else if indexPath.section == 1{
            return 55
        }
        else if indexPath.section == 2{
            return 70
        }
        return UITableViewAutomaticDimension
    }
    
    func createGradientNavBar() {
        
        //Begin, define gradient color shade from RGB(202,92,171) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.73, green: 0.15, blue: 0.56, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.46, green: 0.13, blue: 0.61, alpha: 1).cgColor        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        var navIncludeStatFrame = navigationController!.navigationBar.bounds
        navIncludeStatFrame.size.height += 20
        gradientLayer.frame = navIncludeStatFrame
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //End
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.setBackgroundImage(gradientImage, for: UIBarMetrics.default)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    private func addDemoData(){
        if let context = managedObjectContext{
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
                try self.managedObjectContext?.save()
                print("Demo ActivityData Saved")
            }
                
            catch let error {
                print("Demo ActivityData save error with \(error)")
            }
            
            printDatabaseStatistics()
        }
    }
    
    private func printDatabaseStatistics(){
        managedObjectContext?.perform {
            if let result = try? self.managedObjectContext!.fetch(NSFetchRequest(entityName: "ActivityData")){
                print("Total ActivityDatas in coredata \(result.count)")
            }
        }
    }

}
