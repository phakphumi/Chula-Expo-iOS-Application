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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        createGradientNavBar()
        
        homeTableView.separatorStyle = .none
        
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
// Core Data
    private func updateDatabase()
    {
        managedObjectContext?.perform {
                _ = StageEvent.addData(name: "The event of stage 1", startTime: NSDate(), endTime: NSDate(), desc: "hello event", canReserve: false, numOfSeat: 99, stage: 1, inManageobjectcontext: self.managedObjectContext!)
                _ = StageEvent.addData(name: "The event of stage 2", startTime: NSDate(), endTime: NSDate(), desc: "hello event", canReserve: false, numOfSeat: 99, stage: 2, inManageobjectcontext: self.managedObjectContext!)
                _ = StageEvent.addData(name: "The event of stage 3", startTime: NSDate(), endTime: NSDate(), desc: "hello event", canReserve: false, numOfSeat: 99, stage: 3, inManageobjectcontext: self.managedObjectContext!)
        }
        do {
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
                print("Total datas in coredata \(result.count)")
            }
        }
    }
    
//
    @IBAction func qrcode(_ sender: UIBarButtonItem) {
        
        tabBarController?.performSegue(withIdentifier: "toQRCodeVC", sender: tabBarController)
        
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
            if let slideshowCell = cell as? SlideshowCell{
                let slideshowView = slideshowCell.viewWithTag(slideshowCell.slideshowTag)
                slideshowView?.transform = CGAffineTransform(scaleX: cell.bounds.width / 375, y: cell.bounds.height / 220)
                slideshowView?.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            }
            cell.selectionStyle = .none
        }
        else if indexPath.section == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "Stage", for: indexPath)
            if let stageCell = cell as? StageCell{
//                if let fetchData = fetchedResultsController?.object(at: indexPath) as? EventData
//                {
//                    var name: String?
//                    var startTime: NSDate?
//                    var endTime: NSDate?
//                    var locationDesc: String?
//                    
//                    fetchData.managedObjectContext?.performAndWait
//                        {
//                            // it's easy to forget to do this on the proper queue
//                            
//                            name = fetchData.name
//                            startTime = fetchData.startTime
//                            endTime = fetchData.endTime
//                            locationDesc = fetchData.locationDesc
//                            
//                            // we're not assuming the context is a main queue context
//                            // so we'll grab the screenName and return to the main queue
//                            // to do the cell.textLabel?.text setting
//                    }
//                    if let eventCell = cell as? EventTableViewCell
//                    {
//                        eventCell.name = name
//                        eventCell.startTime = startTime
//                        eventCell.endTime = endTime
//                        eventCell.locationDesc = locationDesc
//                    }
//                }
            }
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "EventFeed", for: indexPath)
                if let eventFeedCell = cell as? EventFeedCell{
                    
                }
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 && indexPath.section == 0 {
            return self.view.bounds.width * 220 / 375
        } else {
            
            return 100
            
        }
        
    }
    
    func createGradientNavBar() {
        
        //Begin, define gradient color shade from RGB(202,92,171) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.8, green: 0.36, blue: 0.67, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.565, green: 0.44, blue: 0.77, alpha: 1).cgColor
        //
        
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
