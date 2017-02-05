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
    
    @IBOutlet weak var topTab: UIView!
    var selectionIndicatorView: UIView = UIView()
    var selectedDate: Int = 1
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
    
    func setupTopTab(){
        var selectionIndicatorFrame : CGRect = CGRect()
        let sectionWidth = topTab.frame.width / 5
        selectionIndicatorFrame = CGRect(x: (sectionWidth * (CGFloat)(selectedDate - 1) ) + 2 , y: topTab.bounds.height-2, width: sectionWidth - 4, height: 2)
        selectionIndicatorView = UIView(frame: selectionIndicatorFrame)
        selectionIndicatorView.backgroundColor = UIColor.brown
        topTab.addSubview(selectionIndicatorView)
        
    }
    
    @IBAction func selectDate(_ sender: Any) {
        if let button = sender as? UIButton{
            selectedDate = button.tag
        }
        moveToptabIndicator()
        
    }

    func moveToptabIndicator(){
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            let sectionWidth = self.topTab.frame.width / 5
            let sectionX = (sectionWidth * (CGFloat)(self.selectedDate - 1) ) + 2
            self.selectionIndicatorView.frame = CGRect(x: sectionX, y: self.topTab.bounds.height-2, width: sectionWidth-4, height: 2)
        })
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
        setupTopTab()
        tableView.reloadData()
//        tableView.contentInset = UIEdgeInsetsMake(((self.navigationController?.navigationBar.frame)?.height)! + (self.navigationController?.navigationBar.frame)!.origin.y, 0.0,  ((self.tabBarController?.tabBar.frame)?.height)!, 0);
        // Uncomment the following line to preserve selection between presentations
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
//        self.tableView.backgroundColor = UIColor.blue
        print("loadedStage")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("layoutStage")
//        setupTopTab()
    }

    
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
                    stageExpandableCell.name = name
                    stageExpandableCell.time = "9:41"
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
