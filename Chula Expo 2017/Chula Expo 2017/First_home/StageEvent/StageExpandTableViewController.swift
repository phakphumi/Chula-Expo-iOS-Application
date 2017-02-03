//
//  StageExpandTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class StageExpandTableViewController: StageExpandableCoreDataTableViewController {
    
    @IBOutlet var tblExpandable: UITableView!
    
    var stageNo: Int?
        {
        didSet
        {
            updateUI()
        }
    }
    var managedObjectContext: NSManagedObjectContext?
        {
        didSet
        {
            updateUI()
        }
    }
    
    var selectSection: Int?{
        didSet{
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

    fileprivate func updateUI(){
        if let context = managedObjectContext{
            if let stageNo = stageNo{
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
//                request.predicate = NSPredicate(format: "stage == %@", stageNo)
                request.sortDescriptors = [NSSortDescriptor(
                    key: "name",
                    ascending: true
//                    selector: #selector(NSDate.compare(_:))
                    )]
                fetchedResultsController = NSFetchedResultsController(
                    fetchRequest: request,
                    managedObjectContext: context,
                    sectionNameKeyPath: "name",
                    cacheName: nil
                )
            }
            else{
                fetchedResultsController = nil
            }
        }
        else{
            fetchedResultsController = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(((self.navigationController?.navigationBar.frame)?.height)! + (self.navigationController?.navigationBar.frame)!.origin.y, 0.0,  ((self.tabBarController?.tabBar.frame)?.height)!, 0);
        // Uncomment the following line to preserve selection between presentations
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
//        self.tableView.backgroundColor = UIColor.blue
    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if indexPath.row == 0{

            cell = tableView.dequeueReusableCell(withIdentifier: "StageEventCell", for: indexPath)
            if let fetchData = fetchedResultsController?.object(at: IndexPath(row: 0, section: indexPath.section)) as? ActivityData{
                    
                var name: String?
//                var desc: String?
                fetchData.managedObjectContext?.performAndWait
                    {
                        name = fetchData.name
//                        desc = fetchData.desc
                }

                if let stageExpandableCell = cell as? StageExpandableCell{
//                    stageExpandableCell.name = name
//                    stageExpandableCell.time = "9:41"
                }
            }
        }
        
        else{
                
            cell = tableView.dequeueReusableCell(withIdentifier: "stageDetail", for: indexPath)
            
//                if let stageDetailCell = cell as? StageDetailCell{
//                    
//                }
        }
        

        // Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectSection == indexPath.section && indexPath.row == 0{
            selectSection = nil
        }
        else{
            selectSection = indexPath.section
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 50
        }else  if indexPath.row == 1 && indexPath.section == selectSection{
            return 90
        }
        return 0;
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 }
