//
//  SearchViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/3/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //@IBOutlet var tableHeader: TableHeaderView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        requestForFeedEvent()
        // ย้ายตำแหน่งลงมาข้างล่างมันยังบัคต้องหาวิธีอื่น
//        tableView.contentInset = UIEdgeInsetsMake(((self.navigationController?.navigationBar.frame)?.height)! + (self.navigationController?.navigationBar.frame)!.origin.y, 0.0,  ((self.tabBarController?.tabBar.frame)?.height)!, 0);
        navigationItem.titleView = searchBar
       // homeTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            do {
                if let frc = fetchedResultsController {
                    frc.delegate = self
                    try frc.performFetch()
                }
                tableView.reloadData()
            } catch let error {
                print("NSFetchedResultsController.performFetch() failed: \(error)")
            }
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
            
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        tableView.reloadData()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 1){
            if let i = fetchedResultsController?.sections?[0]{
                return i.numberOfObjects+1
            }
        }
            return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                var cell: UITableViewCell
        
                if indexPath.section == 0 && indexPath.row == 0 {
        
                    cell = tableView.dequeueReusableCell(withIdentifier: "Map", for: indexPath)
                    cell.selectionStyle = .none
        
                }
        
                else if indexPath.section == 1 && indexPath.row == 0{
                    cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSearch", for: indexPath)
                    if let headerCell = cell as? HeaderSearchTableViewCell{
                        headerCell.title1 = "EVENTS FOR YOU"
                        headerCell.title2 = "แนะนำกิจกรรมที่คุณอาจสนใจ"
                        headerCell.iconImage = "heartIcon"
                    }
                    cell.selectionStyle = .none
              }
               else {
                    cell = tableView.dequeueReusableCell(withIdentifier: "EventSearchFeed", for: indexPath)
                    if let fetchData = fetchedResultsController?.object(at: IndexPath(row: indexPath.row-1, section: 0)) as? ActivityData{
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
                        if let eventFeedCell = cell as? EventfeedTableViewCell{
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 4
        }
        return 0
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            view.backgroundColor = UIColor.clear
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            return self.view.bounds.width * 218 / 375
        }
        else if indexPath.section == 1{
            
            if indexPath.row == 0{
                
                return 58
            }
            
            return 78
        }
        
        return UITableViewAutomaticDimension
        
    }

}


    // Core Data


//
//    


//    // MARK: - Table view data source
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        var cell: UITableViewCell
//        
//        if indexPath.section == 0 && indexPath.row == 0 {
//            
//            cell = tableView.dequeueReusableCell(withIdentifier: "Map", for: indexPath)
//            cell.selectionStyle = .none
//           
//        }
//            
//        else if indexPath.section == 1 && indexPath.row == 0{
//            cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSearch", for: indexPath)
//            if let headerCell = cell as? HeaderSearchTableViewCell{
//                headerCell.title1 = "EVENTS FOR YOU"
//                headerCell.title2 = "แนะนำกิจกรรมที่คุณอาจสนใจ"
//                headerCell.iconImage = "heartIcon"
//            }
//            cell.selectionStyle = .none
//        }
//        else {
//            cell = tableView.dequeueReusableCell(withIdentifier: "Map", for: indexPath)
//            cell.selectionStyle = .none
//        }
//        
//           
       /* else {
 
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
        }*/
//        
//        return cell
//    }
//    

//    private func printDatabaseStatistics(){
//        managedObjectContext?.perform {
//            if let result = try? self.managedObjectContext!.fetch(NSFetchRequest(entityName: "ActivityData")){
//                print("Total ActivityDatas in coredata \(result.count)")
//            }
//        }
//    }
//    
//}
