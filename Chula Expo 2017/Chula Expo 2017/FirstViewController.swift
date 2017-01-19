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
        updateDatabase()
        printDatabaseStatistics()
        requestForStageEvent()
        requestForFeedEvent()
        
//         Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
//
//         Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        createGradientNavBar()
        homeTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
// Core Data
    func requestForStageEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StageEvent")
        request.sortDescriptors = [NSSortDescriptor(
        key: "stage",
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
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventData")
        request.sortDescriptors = [NSSortDescriptor(
            key: "name",
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
    
    private func updateDatabase(){
        
        managedObjectContext?.performAndWait{
            _ = StageEvent.addData(name: "Innovation Show", startTime: NSDate(), endTime: NSDate(), desc: "A robotic vacuum cleaner, often called a robovac, is an autonomous robotic vacuum cleaner that has intelligent programming and a limited vacuum cleaning system. Some designs use spinning brushes to reach tight corners. Others combine a number of cleaning features (mopping, UV sterilization, etc.) simultaneous to vacuuming, thus rendering the machine into more than just a robot “vacuum” cleaner.", canReserve: false, numOfSeat: 99, stage: 1, inManageobjectcontext: self.managedObjectContext!)
            _ = StageEvent.addData(name: "Education UK Grand Exhibition", startTime: NSDate(), endTime: NSDate(), desc: "A robotic vacuum cleaner, often called a robovac, is an autonomous robotic vacuum cleaner that has intelligent programming and a limited vacuum cleaning system. Some designs use spinning brushes to reach tight corners. Others combine a number of cleaning features (mopping, UV sterilization, etc.) simultaneous to vacuuming, thus rendering the machine into more than just a robot “vacuum” cleaner.", canReserve: false, numOfSeat: 99, stage: 2, inManageobjectcontext: self.managedObjectContext!)
            _ = StageEvent.addData(name: "Bangkok Cultural Show", startTime: NSDate(), endTime: NSDate(), desc: "A robotic vacuum cleaner, often called a robovac, is an autonomous robotic vacuum cleaner that has intelligent programming and a limited vacuum cleaning system. Some designs use spinning brushes to reach tight corners. Others combine a number of cleaning features (mopping, UV sterilization, etc.) simultaneous to vacuuming, thus rendering the machine into more than just a robot “vacuum” cleaner.", canReserve: false, numOfSeat: 99, stage: 3, inManageobjectcontext: self.managedObjectContext!)
            
        }
        
        do{
            
            try self.managedObjectContext?.save()
            print("stage event saved")
            
        }
            
        catch let error {
            
            print("stage event saveError with \(error)")
            
        }
        
        printDatabaseStatistics()
        
    }
    
    private func printDatabaseStatistics()
    {
        
        managedObjectContext?.perform {
            if let result = try? self.managedObjectContext!.fetch(NSFetchRequest(entityName: "StageEvent")){
                print("Total stageEvents datas in coredata \(result.count)")
            }
        }
        
    }
    
    @IBAction func qrcode(_ sender: UIBarButtonItem) {
        
        if UserController.loginStatus! {
            
            tabBarController?.performSegue(withIdentifier: "toQRCodeVC", sender: tabBarController)
            
        } else {
            
            let confirm = UIAlertController(title: "Permission denied!", message: "This feature only support for login user.", preferredStyle: UIAlertControllerStyle.alert)
            
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
                if let fetchData = fetchedResultsController?.object(at: IndexPath(row: indexPath.row, section: 0)) as? StageEvent
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
                    stage = Int(fetchData.stage)
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
            }
        }
        else{
            print("section else")
            cell = tableView.dequeueReusableCell(withIdentifier: "EventFeed", for: indexPath)
            if let fetchData = fetchedResultsController2?.object(at: IndexPath(row: indexPath.row, section: 0)) as? EventData{
                var name: String?
                var startTime: NSDate?
                var endTime: NSDate?
                var tumbnail: String?
                var facity: String?
                var date: String?
                fetchData.managedObjectContext?.performAndWait{
                    // it's easy to forget to do this on the proper queue
                    name = fetchData.name
                    startTime = fetchData.startTime
                    endTime = fetchData.endTime
                    tumbnail = fetchData.tumbnail
                    facity = fetchData.facity
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
                    eventFeedCell.tumbnail = tumbnail
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
            return 35
        }
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 && indexPath.section == 0 {
            return self.view.bounds.width * 219 / 375
        }
        else if indexPath.section == 1{
            return 55
        }
        else if indexPath.section == 2{
            return 80
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
        
}
