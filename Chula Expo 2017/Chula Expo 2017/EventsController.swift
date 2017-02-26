//
//  EventsController.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventsController: CoreDataTableViewController {
    
    var facity: String? {
        didSet {
            updateUI()
        }
    }
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            updateUI()
        }
    }
    
//    var isFaculty = false
    
    fileprivate func updateUI() {
        
        if let facity = facity {
            
            if let context = managedObjectContext, (facity.characters.count) > 0 {
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
                
                if facity == "Favourite" {
                    
                    print("Favorite place")
                    request.predicate = NSPredicate(format: "ANY toRound.isFavorite == %@", NSNumber(booleanLiteral: true))
                }
                    
                else if facity == "Reservation" {
                    
                    print("Reserve place")
                    request.predicate = NSPredicate(format: "ANY toRound.isReserve == %@", NSNumber(booleanLiteral: true))
                }
                    
                else {
                    
                    request.predicate = NSPredicate(format: "any faculty contains[c] %@", facity)
                }
                
                request.sortDescriptors = [NSSortDescriptor(
                    key: "activityId",
                    ascending: true
                    )]
                
                fetchedResultsController = NSFetchedResultsController(
                    fetchRequest: request,
                    managedObjectContext: context,
                    sectionNameKeyPath: nil,
                    cacheName: nil
                    )
            }
        }
            
        else {
            
            fetchedResultsController = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            
            if let headCell = cell as? HeaderTableViewCell {
                
                if tableView.numberOfRows(inSection: 0) == 1{
                    
                    headCell.title1 = "EVENT NOT FOUND!"
                    headCell.title2 = "ไม่พบกิจกรรมที่เกี่ยวข้อง"
                    headCell.iconImage = "crossIcon"
                    
                } else {
                    
                    headCell.title1 = "RELATED EVENTS"
                    headCell.title2 = "กิจกรรมที่เกี่ยวข้อง"
                    headCell.iconImage = "relatedeventsIcon"
                }
            }
        }
        
        else{
            
            
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
