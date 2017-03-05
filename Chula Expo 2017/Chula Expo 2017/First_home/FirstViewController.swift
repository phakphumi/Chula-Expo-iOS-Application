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

//    let dateFormatter = DateFormatter()
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    var fetchActivityNowOnstage = [ActivityData?](){
        didSet{
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    let nowDate = Date.from(year: 2017, month: 3, day: 17, hour: 13, minuite: 10)
    
    let slideshowPageViewController = SlideshowPageViewController()
    
    @IBOutlet var homeTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        dateFormatter.timeZone = TimeZone.current
        
        APIController.downloadRecommendActivities(inManageobjectcontext: self.managedObjectContext!, completion: nil)
        
        print("\(Date().toThaiText())")
        
        requestForStageEvent()
        requestForFeedEvent()
        
        fetchActivityNowOnstage = StageActivity.fetchNowOnStageID(manageObjectContext: managedObjectContext!)
        
        homeTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.isTranslucent = true
        self.tabBarController?.tabBar.isTranslucent = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()

    }
    
// Core Data
    func requestForStageEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StageActivity")
//        request.predicate = NSPredicate(format: "isStageEvent = %@ AND stageNo = %i", NSNumber(booleanLiteral: true), 1)
        request.predicate = NSPredicate(format: "stage = 1")

        request.sortDescriptors = [NSSortDescriptor(
        key: "activityId",
        ascending: true
        )]
        
        request.fetchBatchSize = 5
        
        if let context = managedObjectContext {
            
            fetchedResultsControllerStage1 = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
//            request.predicate = NSPredicate(format: "isStageEvent = %@ AND stageNo = %i", NSNumber(booleanLiteral: true), 2)
            request.predicate = NSPredicate(format: "stage = 2")
            fetchedResultsControllerStage2 = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

//            request.predicate = NSPredicate(format: "isStageEvent = %@ AND stageNo = %i", NSNumber(booleanLiteral: true), 3)
            request.predicate = NSPredicate(format: "stage = 3")
            fetchedResultsControllerStage3 = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        }
    }
    func requestForFeedEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
//        request.predicate = NSPredicate(format: "stageNo = 0")
        request.sortDescriptors = [NSSortDescriptor(
            key: "activityId",
            ascending: true
            )]
        request.fetchBatchSize = 20
        if let context = managedObjectContext {
            
            fetchedResultsControllerFeed = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        }
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        tabBarController?.performSegue(withIdentifier: "toSearch", sender: tabBarController)
        
    }
    
    @IBAction func qrcode(_ sender: UIBarButtonItem) {
        
        if UserData.isThereUser(inManageobjectcontext: self.managedObjectContext!) {
            
            tabBarController?.performSegue(withIdentifier: "toQRCode", sender: tabBarController)
            
        } else {
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ฟังก์ชัน QR Code เปิดให้ใช้งานได้เฉพาะ Facebook User เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
        
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
            slideshowPageViewController.view.transform = CGAffineTransform(scaleX: cell.bounds.width / 375, y: cell.bounds.height / 220)
            slideshowPageViewController.view.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            var images: [String] = []
            var titles: [String] = []
            var desc: [String] = []
            
            managedObjectContext?.performAndWait {
                
                let fetchdata = HighlightActivity.fetchAllHighlight(inManageobjectcontext: self.managedObjectContext!)
                
                for data in fetchdata{
                    
                    images.append(data.bannerUrl ?? "")
                    titles.append(data.name ?? "")
                    desc.append(data.shortDesc ?? "")
                }
            }
            
            slideshowPageViewController.imageName = images
            slideshowPageViewController.topicLabelText = titles
            slideshowPageViewController.descLabelText = desc
   
            self.addChildViewController(slideshowPageViewController)
            cell.contentView.addSubview(slideshowPageViewController.view)
        }
            
        else if indexPath.section == 1 && indexPath.row == 0{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            if let headerCell = cell as? HeaderTableViewCell{
                headerCell.title1 = "NOW ON STAGE"
                headerCell.title2 = "กิจกรรมที่กำลังเกิดขึ้นบนเวทีในขณะนี้"
                headerCell.iconImage = "playIcon"
            }
            cell.selectionStyle = .none
        }
            
        else if indexPath.section == 1{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Stage", for: indexPath)
            
            if let stageCell = cell as? StageCell {
                if let activity = fetchActivityNowOnstage[indexPath.row-1] {
                    
                    stageCell.name = activity.name
                    
                    if let sTime = activity.start, let eTime = activity.end{
                         stageCell.time = ("\(sTime.toTimeText()) - \(eTime.toTimeText()) • แตะเพื่อดูกิจกรรมเพิ่มเติม")
                    }
                   
                    
                }
                else{
                    
                    stageCell.name = "ไม่พบกิจกรรมบนเวทีในขณะนี้"
                    stageCell.stage = indexPath.row
                }
                
                stageCell.stage = indexPath.row
            }
            
//            let seperator = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 3))
//            seperator.backgroundColor = UIColor.clear
//            cell.contentView.addSubview(seperator)
            
        }
    
        else if indexPath.section == 2 && indexPath.row == 0{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            if let headerCell = cell as? HeaderTableViewCell{
                headerCell.title1 = "EVENTS FOR YOU"
                headerCell.title2 = "แนะนำกิจกรรมที่คุณอาจสนใจ"
                headerCell.iconImage = "heartIcon"
            }
            
        }

        else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "EventFeed", for: indexPath)
            if let fetchData = (fetchedResultsControllerFeed?.object(at: IndexPath(row: indexPath.row-1, section: 0)) as? RecommendActivity)?.toActivity{
                var name: String?
                var thumbnail: String?
                var toRound: NSSet?
                var facity: String?
                var activityId: String?
                var time: String?
                fetchData.managedObjectContext?.performAndWait{
                    name = fetchData.name
                    thumbnail = fetchData.thumbnailsUrl
                    facity = fetchData.faculty
                    toRound = fetchData.toRound
                    
                    activityId = fetchData.activityId
                    if let stime = fetchData.start{
                        if let eTime = fetchData.end{
                            time = stime.toThaiText(withEnd: eTime)
                        }
                    }
                    if let toRound = toRound{
                        if time != nil{
                            if toRound.count > 0 {
                                time = ("\(time!) + \(toRound.count) รอบ")
                            }
                        }
                    }
                }
                
                if let eventFeedCell = cell as? EventFeedCell{
                    eventFeedCell.manageObjectContext = managedObjectContext
                    if name != nil{
                        eventFeedCell.name = name
                    }
                    if time != nil{
                        eventFeedCell.timeText = time
                    }
                    eventFeedCell.eventTumbnailImage.image = #imageLiteral(resourceName: "defaultImage")
                    eventFeedCell.thumbnail = thumbnail
                    eventFeedCell.facity = facity
                    eventFeedCell.activityId = activityId
                    eventFeedCell.toRound = toRound
                }
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 4
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            view.backgroundColor = UIColor.clear
            return view
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 && indexPath.section == 0 {
            return self.view.bounds.width * 218 / 375
        }
        else if indexPath.section == 1{
            
            if indexPath.row == 0{
                
                return 58
            }
            
            return 63
        }
        else if indexPath.section == 2{
            
            if indexPath.row == 0{
                
                return 58
            }
            
            return 78
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stageSelect"{
//            print("segue")
            if let dest = segue.destination as? StageExpandTableViewController{
                dest.managedObjectContext = managedObjectContext
                
                if let stageNo = (sender as? StageCell)?.stage{
                    dest.stageNo = stageNo
                    dest.title = "Stage \(stageNo) Schedule"
                    let day = nowDate.checkInday()
                    if day > 0{
                        dest.dateForDefault = day
                    }
                }
            }
        }

        if segue.identifier == "toEventDetail" {
            
            if let destination = segue.destination as? EventDetailTableViewController{
                
                if let eventcell = sender as? EventFeedCell{
                    
                    if let id = eventcell.activityId{
                        
                        ActivityData.fetchActivityData(activityId: id, inManageobjectcontext: managedObjectContext!, completion: { (activityData) in
                            
                            if let activityData = activityData {
                                
                                destination.activityId = activityData.activityId
                                destination.bannerUrl = activityData.bannerUrl
                                destination.topic = activityData.name
                                destination.locationDesc = ""
                                destination.toRounds = activityData.toRound
                                destination.desc = activityData.desc
                                destination.room = activityData.room
                                destination.place = activityData.place
                                destination.zoneId = activityData.faculty
                                destination.latitude = activityData.latitude
                                destination.longitude = activityData.longitude
                                destination.pdf = activityData.pdf
                                destination.toImages = activityData.toImages
                                destination.toTags = activityData.toTags
                                destination.start = activityData.start
                                destination.end = activityData.end
                                destination.timeDesc = eventcell.timeText
                                destination.managedObjectContext = self.managedObjectContext
                                
                            }
                            
                        })
                        
                    }
                }
            }
        }
    }

//<<<<<<< HEAD
//    private func addDemoData(){
//        if let context = managedObjectContext{
//            // add demo data
//            context.performAndWait {
//                _ = ActivityData.addStageEventData(
//                    activityId: "001",
//                    stageNo: 1,
//                    name: "Stage 1 event",
//                    desc: "stage 1 desc",
//                    startTime: NSDate(),
//                    endTime: NSDate(),
//                    isFavorite: false,
//                    reservable: true,
//                    fullCapacity: 100,
//                    reserved: 15,
//                    seatAvaliable: 17,
//                    isReserve: false,
//                    inManageobjectcontext: context)
//                _ = ActivityData.addStageEventData(
//                    activityId: "002",
//                    stageNo: 2,
//                    name: "Stage 2 event",
//                    desc: "stage 2 desc",
//                    startTime: NSDate(),
//                    endTime: NSDate(),
//                    isFavorite: false,
//                    reservable: true,
//                    fullCapacity: 90,
//                    reserved: 1,
//                    seatAvaliable: 0,
//                    isReserve: false,
//                    inManageobjectcontext: context)
//                _ = ActivityData.addStageEventData(
//                    activityId: "003",
//                    stageNo: 3,
//                    name: "Stage 3 event",
//                    desc: "stage 3 desc",
//                    startTime: NSDate(),
//                    endTime: NSDate(),
//                    isFavorite: false,
//                    reservable: true,
//                    fullCapacity: 2,
//                    reserved: 1,
//                    seatAvaliable: 1,
//                    isReserve: false,
//                    inManageobjectcontext: context)
//                _ = ActivityData.addEventData(
//                    activityId: "004",
//                    name: "event 1 test test",
//                    desc: "Hello activity 1 description",
//                    locationDesc: "101 Floor 1 ENG 3",
//                    bannerUrl: "technology",
//                    thumbnailsUrl: "technology",
//                    startTime: NSDate(),
//                    endTime: NSDate(),
//                    isFavorite: false,
//                    isHighlight: true,
//                    reservable: false,
//                    fullCapacity: 20,
//                    reserved: 0,
//                    seatAvaliable: 20,
//                    isReserve: false,
//                    toImages: NSSet(object: ImageData.addData(url: "technology", inManageobjectcontext: context)!),
//                    toRounds: NSSet(object: RoundData.addData(id: "1", activityId: "004", roundNo: 1, startTime: self.dateFormatter.date(from: "2017-03-15T10:00:00.000Z")!, endTime: self.dateFormatter.date(from: "2017-03-15T11:00:00.000Z")!, reservable: false, seatAvaliable: 0, reserved: 0, fullCapacity: 0, isReserve: false, isFavorite: false, isHighlight: false, inManageobjectcontext: context)),
//                    toVideos: NSSet(object: VideoData.addData(title: "video 1", url: "youtube url", inManageobjectcontext: context)!),
//                    toTags: NSSet(object: TagData.addData(name: "Tech", inManageobjectcontext: context)!),
//                    toFaculty: NSSet(object: FacultyData.addData(name: "Faculty of Engineering", shortName: "ENG", inManageobjectcontext: context)!),
//                    inManageobjectcontext: context)
//                
//                _ = ActivityData.addEventData(
//                    activityId: "005",
//                    name: "Cryonics a new life",
//                    desc: "Death occurs when the chemistry of life becomes so disorganized that normal operation cannot be restored. (Death is not when life turns off. People can and have survived being \"turned off\".) How much chemical disorder can be survived depends on medical technology. A hundred years ago, cardiac arrest was irreversible. People were called dead when their heart stopped beating. Today death is believed to occur 4 to 6 minutes after the heart stops beating because after several minutes it is difficult to resuscitate the brain. However, with new experimental treatments, more than 10 minutes of warm cardiac arrest can now be survived without brain injury. Future technologies for molecular repair may extend the frontiers of resuscitation beyond 60 minutes or more, making today's beliefs about when death occurs obsolete. Ultimately, real death occurs when cell structure and chemistry become so disorganized that no technology could restore the original state. This is called the information-theoretic criterion for death. Any other definition of death is arbitrary and subject to continual revision as technology changes. That is certainly the case for death pronounced on the basis of absent \"vital signs\" today, which is not real death at all. The object of cryonics is to prevent death by preserving sufficient cell structure and chemistry so that recovery (including recovery of memory and personality) remains possible by foreseeable technology. If indeed cryonics patients are recoverable in the future, then clearly they were never really dead in the first place. Today's physicians will simply have been wrong about when death occurs, as they have been so many times in the past. The argument that cryonics cannot work because cryonics patients are dead is a circular argument.",
//                    locationDesc: "Medicine Building 1000",
//                    bannerUrl: "cryonics",
//                    thumbnailsUrl: "cryonics",
//                    startTime: NSDate(),
//                    endTime: NSDate(),
//                    isFavorite: false,
//                    isHighlight: true,
//                    reservable: true,
//                    fullCapacity: 55,
//                    reserved: 12,
//                    seatAvaliable: 13,
//                    isReserve: false,
//                    toImages: NSSet(objects:
//                                             ImageData.addData(url: "cryonics1", inManageobjectcontext: context)!,
//                                             ImageData.addData(url: "cryonics2", inManageobjectcontext: context)!,
//                                             ImageData.addData(url: "cryonics3", inManageobjectcontext: context)!,
//                                             ImageData.addData(url: "cryonics4", inManageobjectcontext: context)!,
//                                             ImageData.addData(url: "cryonics5", inManageobjectcontext: context)!),
//                    toRounds: NSSet(objects: RoundData.addData(
//                                                                id: "2",
//                                                                activityId: "005",
//                                                                roundNo: 1,
//                                                                startTime: self.dateFormatter.date(from: "2017-03-15T08:00:00.000Z")!,
//                                                                endTime: self.dateFormatter.date(from: "2017-03-15T09:00:00.000Z")!,
//                                                                reservable: false,
//                                                                seatAvaliable: 0,
//                                                                reserved: 0,
//                                                                fullCapacity: 0,
//                                                                isReserve: false,
//                                                                isFavorite: false,
//                                                                isHighlight: false,
//                                                                inManageobjectcontext: context),
//                                        RoundData.addData(
//                                                                id: "3",
//                                                                activityId: "005",
//                                                                roundNo: 2,
//                                                                startTime: self.dateFormatter.date(from: "2017-03-15T09:00:00.000Z")!,
//                                                                endTime: self.dateFormatter.date(from: "2017-03-15T10:00:00.000Z")!,
//                                                                reservable: false,
//                                                                seatAvaliable: 0,
//                                                                reserved: 0,
//                                                                fullCapacity: 0,
//                                                                isReserve: false,
//                                                                isFavorite: false,
//                                                                isHighlight: false,
//                                                                inManageobjectcontext: context),
//                                        RoundData.addData(
//                                                                id: "4",
//                                                                activityId: "005",
//                                                                roundNo: 3,
//                                                                startTime: self.dateFormatter.date(from: "2017-03-15T10:00:00.000Z")!,
//                                                                endTime: self.dateFormatter.date(from: "2017-03-15T11:00:00.000Z")!,
//                                                                reservable: false,
//                                                                seatAvaliable: 0,
//                                                                reserved: 0,
//                                                                fullCapacity: 0,
//                                                                isReserve: false,
//                                                                isFavorite: false,
//                                                                isHighlight: false,
//                                                                inManageobjectcontext: context),
//                                        RoundData.addData(
//                                                                id: "6",
//                                                                activityId: "005",
//                                                                roundNo: 5,
//                                                                startTime: self.dateFormatter.date(from: "2017-03-16T08:00:00.000Z")!,
//                                                                endTime: self.dateFormatter.date(from: "2017-03-16T09:00:00.000Z")!,
//                                                                reservable: false,
//                                                                seatAvaliable: 0,
//                                                                reserved: 0,
//                                                                fullCapacity: 0,
//                                                                isReserve: false,
//                                                                isFavorite: false,
//                                                                isHighlight: false,
//                                                                inManageobjectcontext: context),
//                                        RoundData.addData(
//                                                                id: "7",
//                                                                activityId: "005",
//                                                                roundNo: 6,
//                                                                startTime: self.dateFormatter.date(from: "2017-03-16T09:00:00.000Z")!,
//                                                                endTime: self.dateFormatter.date(from: "2017-03-16T10:00:00.000Z")!,
//                                                                reservable: false,
//                                                                seatAvaliable: 0,
//                                                                reserved: 0,
//                                                                fullCapacity: 0,
//                                                                isReserve: false,
//                                                                isFavorite: false,
//                                                                isHighlight: false,
//                                                                inManageobjectcontext: context),
//                                        RoundData.addData(
//                                                                id: "8",
//                                                                activityId: "005",
//                                                                roundNo: 7,
//                                                                startTime: self.dateFormatter.date(from: "2017-03-16T12:00:00.000Z")!,
//                                                                endTime: self.dateFormatter.date(from: "2017-03-16T13:00:00.000Z")!,
//                                                                reservable: false,
//                                                                seatAvaliable: 0,
//                                                                reserved: 0,
//                                                                fullCapacity: 0,
//                                                                isReserve: false,
//                                                                isFavorite: false,
//                                                                isHighlight: false,
//                                                                inManageobjectcontext: context)
//                    
//                    ),
//                    toVideos: NSSet(object: VideoData.addData(title: "video 1", url: "youtube url", inManageobjectcontext: context)!),
//                    toTags: NSSet(objects: TagData.addData(name: "Technology", inManageobjectcontext: context)!,
//                                           TagData.addData(name: "Medicine", inManageobjectcontext: context)!,
//                                           TagData.addData(name: "Science", inManageobjectcontext: context)!),
//                    toFaculty: NSSet(object: FacultyData.addData(name: "Faculty of Medicine", shortName: "MED", inManageobjectcontext: context)!),
//                    inManageobjectcontext: context)
//            }
//            
//            do{
//                try self.managedObjectContext?.save()
//                print("Demo ActivityData Saved")
//            }
//                
//            catch let error {
//                print("Demo ActivityData save error with \(error)")
//            }
//            
//            printDatabaseStatistics()
//        }
//    }
//    
//=======
//>>>>>>> 452283a998244bd838bfee71779c422b1874b606
    private func printDatabaseStatistics(){
        managedObjectContext?.perform {
            if let result = try? self.managedObjectContext!.fetch(NSFetchRequest(entityName: "ActivityData")){
                print("Total ActivityDatas in coredata \(result.count)")
            }
        }
    }

}
