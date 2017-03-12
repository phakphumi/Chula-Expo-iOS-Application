//
//  FirstViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData
import Answers

class FirstViewController: MainCoreDataTableViewController{
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    var fetchActivityNowOnstage = [ActivityData?](){
        didSet{
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    var images: [String] = []
    var titles: [String] = []
    var desc: [String] = []
    
    var nowDate = Date()
    let slideshowPageViewController = SlideshowPageViewController()
    
    @IBOutlet var homeTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Answers.logContentView(withName: "First",
                               contentType: nil,
                               contentId: nil,
                               customAttributes: nil)
        
//        StageActivity.getNumberOfStage(inManageobejectcontext: managedObjectContext!)
        
        let fetchRecommendData = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        let requestDeleteRecommendData = NSBatchDeleteRequest(fetchRequest: fetchRecommendData)
        do{
            try managedObjectContext!.execute(requestDeleteRecommendData)
        } catch let error {
            
            print(error)
            
        }
        
        fetchActivityNowOnstage = StageActivity.fetchNowOnStageID(manageObjectContext: managedObjectContext!)
        APIController.downloadRecommendActivities(inManageobjectcontext: self.managedObjectContext!, completion: nil)
        APIController.downloadStageActivities(inManageobjectcontext: self.managedObjectContext!, completion: nil)
        
        print("now time is == \(nowDate.toThaiText())")
        
        requestForFeedEvent()
        
        
        homeTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        
        
        refreshControl = UIRefreshControl()
        refreshControl!.backgroundColor = UIColor.white
        refreshControl!.tintColor = UIColor.gray
        refreshControl!.attributedTitle = NSAttributedString(string: "")
        refreshControl!.addTarget(self, action: #selector(FirstViewController.handleRefresh(sender:)), for: UIControlEvents.valueChanged)
        tableView?.addSubview(refreshControl!)
        
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
    
    
    func handleRefresh(sender refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        fetchActivityNowOnstage = StageActivity.fetchNowOnStageID(manageObjectContext: managedObjectContext!)        
        let fetchRecommendData = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        let requestDeleteRecommendData = NSBatchDeleteRequest(fetchRequest: fetchRecommendData)
        let fetchStageData = NSFetchRequest<NSFetchRequestResult>(entityName: "StageActivity")
        let requestDeleteStageData = NSBatchDeleteRequest(fetchRequest: fetchStageData)
        let fetchHighlightData = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
        let requestDeleteHighlightData = NSBatchDeleteRequest(fetchRequest: fetchHighlightData)
        
        do{
            
            try managedObjectContext!.execute(requestDeleteRecommendData)
            try managedObjectContext!.execute(requestDeleteStageData)
            try managedObjectContext!.execute(requestDeleteHighlightData)
            try managedObjectContext!.save()
        } catch let error {
            
            print(error)
            
        }
        fetchActivityNowOnstage = StageActivity.fetchNowOnStageID(manageObjectContext: managedObjectContext!)

        
//        APIController.downloadRecommendActivities(inManageobjectcontext: self.managedObjectContext!) { (success) in
//
//            if success {
//                
//                APIController.downloadHightlightActivities(inManageobjectcontext: self.managedObjectContext!, completion: { (success) in
//                    
//                    if success {
////                        self.reloadSlideShow(finishload: true)
//                        APIController.downloadStageActivities(inManageobjectcontext: self.managedObjectContext!, completion: {
//                        (finish) in
//                            if finish {
////                                self.reloadSlideShow(finishload: true)
//                                StageActivity.getNumberOfStage(inManageobejectcontext: self.managedObjectContext!)
//                            }
//                        })
//                    }
//                })
//            }
//        }

        
//        managedObjectContext?.performAndWait {
//            
//            APIController.downloadHightlightActivities(inManageobjectcontext: self.managedObjectContext!, completion: nil)
//            APIController.downloadHightlightActivities(inManageobjectcontext: self.managedObjectContext!, completion: nil)
//            APIController.downloadStageActivities(inManageobjectcontext: self.managedObjectContext!, completion: nil)
//
//        }
        
        APIController.downloadRecommendActivities(inManageobjectcontext: self.managedObjectContext!) { (success) in
            if success {
                
                APIController.downloadHightlightActivities(inManageobjectcontext: self.managedObjectContext!, completion: { (success) in
                    
                    if success {
                        //                        self.reloadSlideShow(finishload: true)
                        APIController.downloadStageActivities(inManageobjectcontext: self.managedObjectContext!, completion: {
                            (finish) in
                            if finish {
                                //                                self.reloadSlideShow(finishload: true)
//                                StageActivity.getNumberOfStage(inManageobejectcontext: self.managedObjectContext!)
                            }
                        })
                    }
                })
            }
        }
        
//        StageActivity.fetchStageActivities(inManageobjectcontext: self.managedObjectContext!)
        
//        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.reloadSections([0], with: .none)
        tableView.reloadData()
        requestForFeedEvent()
        StageActivity.getNumberOfStage(inManageobejectcontext: self.managedObjectContext!)
        
        
        
        refreshControl.endRefreshing()
    }
    
// Core Data
    
    func reloadSlideShow(finishload:Bool){
        if finishload{
            images.removeAll()
            titles.removeAll()
            desc.removeAll()
            managedObjectContext?.performAndWait {
                
                let fetchdata = HighlightActivity.fetchAllHighlight(inManageobjectcontext: self.managedObjectContext!)
                
                for data in fetchdata{
                    
                    self.images.append(data.bannerUrl ?? "")
                    self.titles.append(data.name ?? "")
                    self.desc.append(data.shortDesc ?? "")
                }
            }
            
            slideshowPageViewController.imageName = images
            slideshowPageViewController.topicLabelText = titles
            slideshowPageViewController.descLabelText = desc
            
            slideshowPageViewController.setupData()
            //        self.addChildViewController(slideshowPageViewController)
            slideshowPageViewController.view.tag = 9
            
            let indexPath = IndexPath(item: 0, section: 0)
            if let slideshow = tableView.cellForRow(at: indexPath)?.contentView.viewWithTag(9){
                slideshow.removeFromSuperview()
            }
            if let cell = tableView.cellForRow(at: indexPath){
                cell.contentView.addSubview(slideshowPageViewController.view)
            }

        }
    }
    
    
    func requestForFeedEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        request.sortDescriptors = [NSSortDescriptor(
            key: "toActivity.name",
            ascending: true
            )]
        request.fetchBatchSize = 5
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
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ฟังก์ชัน QR Code เปิดให้ใช้งานได้เฉพาะผู้ใช้ที่ลงทะเบียนผ่าน Facebook เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "เข้าสู่ระบบด้วย Facebook", style: UIAlertActionStyle.default, handler: { (alert) in
                
                self.tabBarController?.performSegue(withIdentifier: "logout", sender: self)
                
            }))
            confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.destructive, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(_ sender: UITapGestureRecognizer){
        
        if titles.count > slideshowPageViewController.frameIndex{
            tabBarController?.performSegue(withIdentifier: "toDetail", sender: titles[slideshowPageViewController.frameIndex])
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Slideshow", for: indexPath)
            slideshowPageViewController.view.transform = CGAffineTransform(scaleX: cell.bounds.width / 375, y: cell.bounds.height / 220)
            slideshowPageViewController.view.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            
                images.removeAll()
                titles.removeAll()
                desc.removeAll()
            
            managedObjectContext?.performAndWait {
                
                let fetchdata = HighlightActivity.fetchAllHighlight(inManageobjectcontext: self.managedObjectContext!)
                
                for data in fetchdata{
                    
                    self.images.append(data.bannerUrl ?? "")
                    self.titles.append(data.name ?? "")
                    self.desc.append(data.shortDesc ?? "")
                }
            }
            
            slideshowPageViewController.imageName = images
            slideshowPageViewController.topicLabelText = titles
            slideshowPageViewController.descLabelText = desc
   
            self.addChildViewController(slideshowPageViewController)
            slideshowPageViewController.view.tag = 9
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            cell.contentView.addGestureRecognizer(tap)
            
            cell.contentView.addSubview(slideshowPageViewController.view)
            
        }
            
        else if indexPath.section == 1 && indexPath.row == 0{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            if let headerCell = cell as? HeaderTableViewCell{
                headerCell.title1 = "NOW ON STAGE"
                headerCell.title2 = "กิจกรรมที่กำลังเกิดขึ้นบนเวทีในขณะนี้"
                headerCell.iconImage = "playIcon"
            }
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
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
         if identifier == "toDetail"{
            if desc.count <= slideshowPageViewController.frameIndex {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stageSelect"{
            print("segue")
            StageActivity.getNumberOfStage(inManageobejectcontext: managedObjectContext!)
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
        
        else if segue.identifier == "toDetail"{
            //            print("segue")
            if let destination = segue.destination as? EventDetailTableViewController{
                if desc.count > slideshowPageViewController.frameIndex{
                    let name = titles[slideshowPageViewController.frameIndex]
                    var activity: ActivityData?
                    managedObjectContext!.performAndWait {
                        activity = ActivityData.fetchActivityFromFullName(name: name, inManageobjectcontext: self.managedObjectContext!)
                    }
                    
                    
                    if let activityData = activity {
                        
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
                        //                    destination.timeDesc = eventcell.timeText
                        destination.managedObjectContext = managedObjectContext
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
