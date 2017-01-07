//
//  EventsTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/7/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventsTableViewController: CoreDataTableViewController {
    
    var facity: String?{
        didSet{
            updateUI()
        }
    }
    var managedObjectContext: NSManagedObjectContext? {
        didSet{
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        if let context = managedObjectContext, (facity?.characters.count)! > 0 {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventData")
            request.predicate = NSPredicate(format: "facity = %@", facity!)
            request.sortDescriptors = [NSSortDescriptor(
                key: "facity",
                ascending: true,
                selector: #selector(NSString.compare(_:))
                )]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: "dateSection",
                cacheName: nil
            )
        } else {
            fetchedResultsController = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventDetail", for: indexPath)
        
        if let fetchData = fetchedResultsController?.object(at: indexPath) as? EventData {
            var name: String?
            var stime: NSDate?
            fetchData.managedObjectContext?.performAndWait {
                // it's easy to forget to do this on the proper queue
                name = fetchData.name
                stime = fetchData.startTime
                
                // we're not assuming the context is a main queue context
                // so we'll grab the screenName and return to the main queue
                // to do the cell.textLabel?.text setting
            }
            if let eventCell = cell as? EventTableViewCell{
                eventCell.name = name
                eventCell.sTime = stime
            }
        }
        
        // Configure the cell...
        
        return cell
    }


}
