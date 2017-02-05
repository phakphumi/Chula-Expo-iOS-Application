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
    @IBOutlet var tableHeader: TableHeaderView!
    @IBOutlet var tableHeader2: TableHeaderView!
    @IBOutlet weak var facityCapsule: UILabel!
    @IBOutlet weak var reserveCapsule: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        requestForStageEvent()
        requestForFeedEvent()
        
        homeTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()

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
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        tabBarController?.performSegue(withIdentifier: "toSearch", sender: tabBarController)
        
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
            if let fetchData = fetchedResultsController?.object(at: IndexPath(row: indexPath.row - 1, section: 0)) as? ActivityData
            {
                
                var name: String?
                var round: NSSet?
                var stage: Int?
                fetchData.managedObjectContext?.performAndWait                {
                    // it's easy to forget to do this on the proper queue
                    name = fetchData.name
                    round = fetchData.toRound
                    stage = Int(fetchData.stageNo)
                    // we're not assuming the context is a main queue context
                    // so we'll grab the screenName and return to the main queue
                    // to do the cell.textLabel?.text setting
                }
                if let stageCell = cell as? StageCell{
                    stageCell.name = name
                    stageCell.toRound = round
                    stageCell.stage = stage
                }
                let seperator = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 3))
                seperator.backgroundColor = UIColor.clear
                cell.contentView.addSubview(seperator)
            }
        }
            
        else if indexPath.section == 2 && indexPath.row == 0{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            if let headerCell = cell as? HeaderTableViewCell{
                headerCell.title1 = "EVENTS FOR YOU"
                headerCell.title2 = "แนะนำกิจกรรมที่คุณอาจสนใจ"
                headerCell.iconImage = "heartIcon"
            }
            cell.selectionStyle = .none
        }

        else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "EventFeed", for: indexPath)
            if let fetchData = fetchedResultsController2?.object(at: IndexPath(row: indexPath.row-1, section: 0)) as? ActivityData{
                var name: String?
                var toRound: NSSet?
                var thumbnail: String?
                var facity: NSSet?
                fetchData.managedObjectContext?.performAndWait{
                    // it's easy to forget to do this on the proper queue
                    name = fetchData.name
                    thumbnail = fetchData.thumbnailsUrl
                    facity = fetchData.toFaculty
                    toRound = fetchData.toRound
                    // we're not assuming the context is a main queue context
                    // so we'll grab the screenName and return to the main queue
                    // to do the cell.textLabel?.text setting
                }
                print("feedCell name == \(name)")
                if let eventFeedCell = cell as? EventFeedCell{
                    print("feedCell name == \(name)")
                    eventFeedCell.name = name
                    eventFeedCell.toRound = toRound
                    eventFeedCell.thumbnail = thumbnail
                    eventFeedCell.facity = facity
                }
            }
        }
        
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
            print("segueee")
            if let dest = segue.destination as? StageExpandTableViewController{
                dest.managedObjectContext = managedObjectContext
                dest.stageNo = 1
                if let stageNo = (sender as? StageCell)?.stage{
                    dest.title = "Stage \(stageNo) Schedule"
                }
            }
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
