//
//  EventsTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/7/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventsTableViewController: CoreDataTableViewController
{
    
    var selectedActivityId: String?
    var facity: String?
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
    
    fileprivate func updateUI()
    {
        if let context = managedObjectContext, (facity?.characters.count)! > 0
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            
            if facity == "Favourites" {
                request.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(booleanLiteral: true))
            }
            else if facity == "Reservations" {
                request.predicate = NSPredicate(format: "isReserve == %@", NSNumber(booleanLiteral: true))
            }
            else {
                request.predicate = NSPredicate(format: "any toFaculty.name contains[c] %@", facity!)
            }
            
            request.sortDescriptors = [NSSortDescriptor(
                key: "startTime",
                ascending: true,
                selector: #selector(NSDate.compare(_:))
                )]
            
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: "dateSection",
                cacheName: nil
            )
        }
        else
        {
            fetchedResultsController = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventDetail", for: indexPath)
        
        if let fetchData = fetchedResultsController?.object(at: indexPath) as? ActivityData
        {
            var activityId: String?
            var name: String?
            var startTime: NSDate?
            var endTime: NSDate?
            var locationDesc: String?
            
            fetchData.managedObjectContext?.performAndWait
            {
                // it's easy to forget to do this on the proper queue
                
                activityId = fetchData.activityId
                name = fetchData.name
                startTime = fetchData.startTime
                endTime = fetchData.endTime
                locationDesc = fetchData.locationDesc
                
                // we're not assuming the context is a main queue context
                // so we'll grab the screenName and return to the main queue
                // to do the cell.textLabel?.text setting
            }
            if let eventCell = cell as? EventTableViewCell
            {
                eventCell.activitiyId = activityId
                eventCell.name = name
                eventCell.startTime = startTime
                eventCell.endTime = endTime
                eventCell.locationDesc = locationDesc
            }
        }
        
        // Configure the cell...
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as? EventTableViewCell
        
        selectedActivityId = currentCell?.activitiyId
        
        self.performSegue(withIdentifier: "toEventDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEventDetails" {
            
            let destination = segue.destination as! EventDetailsTableViewController
            
            destination.activityId = selectedActivityId
            
        }
        
    }
    
}
