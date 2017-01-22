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
    var selectedName: String?
    var selectedStartTime: NSDate?
    var selectedEndTime: NSDate?
    var selectedLocationDesc: String?
    var selectedDesc: String?
    var selectedBannerUrl: String?
    var selectedIsHighlight: Bool?
    var selectedIsFavorite: Bool?
    var selectedReservable: Bool?
    var selectedIsReserve: Bool?
    var selectedToTags: NSSet?
    var selectedToFaculty: NSSet?
    var selectedToImages: NSSet?
    var selectedToVideos: NSSet?
    var selectedDateText: String?
        
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
            var desc: String?
            var bannerUrl: String?
            var isHighlight: Bool?
            var isFavorite: Bool?
            var reservable: Bool?
            var isReserve: Bool?
            var toTags: NSSet?
            var toFaculty: NSSet?
            var toImages: NSSet?
            var toVideos: NSSet?
            var dateText: String?
            
            var name: String?
            var startTime: NSDate?
            var endTime: NSDate?
            var locationDesc: String?

            fetchData.managedObjectContext?.performAndWait
            {
                // it's easy to forget to do this on the proper queue
                
                name = fetchData.name
                startTime = fetchData.startTime
                endTime = fetchData.endTime
                locationDesc = fetchData.locationDesc
                
                activityId = fetchData.activityId
                desc = fetchData.desc
                bannerUrl = fetchData.bannerUrl
                isHighlight = fetchData.isHighlight
                isFavorite = fetchData.isFavorite
                reservable = fetchData.reservable
                isReserve = fetchData.isReserve
                toTags = fetchData.toTags
                toFaculty = fetchData.toFaculty
                toImages = fetchData.toImages
                toVideos = fetchData.toVideos
                dateText = fetchData.dateText
                // we're not assuming the context is a main queue context
                // so we'll grab the screenName and return to the main queue
                // to do the cell.textLabel?.text setting
            }
            if let eventCell = cell as? EventTableViewCell
            {
                
                eventCell.name = name
                eventCell.startTime = startTime
                eventCell.endTime = endTime
                eventCell.locationDesc = locationDesc
                
                eventCell.activityId = activityId
                eventCell.desc = desc
                eventCell.bannerUrl = bannerUrl
                eventCell.isHighlight = isHighlight
                eventCell.isFavorite = isFavorite
                eventCell.reservable = reservable
                eventCell.isReserve = isReserve
                eventCell.toTags = toTags
                eventCell.toFaculty = toFaculty
                eventCell.toImages = toImages
                eventCell.toVideos = toVideos
                eventCell.dateText = dateText
                
            }
        }
        
        // Configure the cell...
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as? EventTableViewCell
        
        selectedActivityId = currentCell?.activityId
        selectedName = currentCell?.name
        selectedStartTime = currentCell?.startTime
        selectedEndTime = currentCell?.endTime
        selectedLocationDesc = currentCell?.locationDesc
        selectedDesc = currentCell?.desc
        selectedBannerUrl = currentCell?.bannerUrl
        selectedIsHighlight = currentCell?.isHighlight
        selectedIsFavorite = currentCell?.isFavorite
        selectedReservable = currentCell?.reservable
        selectedIsReserve = currentCell?.isReserve
        selectedToTags = currentCell?.toTags
        selectedToFaculty = currentCell?.toFaculty
        selectedToImages = currentCell?.toImages
        selectedToVideos = currentCell?.toVideos
        selectedDateText = currentCell?.dateText
            
        self.performSegue(withIdentifier: "toEventDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEventDetails" {
            
            let destination = segue.destination as! EventDetailsTableViewController
            
            destination.activityId = selectedActivityId
            destination.name = selectedName
            destination.startTime = selectedStartTime
            destination.endTime = selectedEndTime
            destination.locationDesc = selectedLocationDesc
            destination.desc = selectedDesc
            destination.bannerUrl = selectedBannerUrl
            destination.isHighlight = selectedIsHighlight
            destination.isFavorite = selectedIsFavorite
            destination.reservable = selectedReservable
            destination.isReserve = selectedIsReserve
            destination.toTags = selectedToTags
            destination.toFaculty = selectedToFaculty
            destination.toImages = selectedToImages
            destination.toVideos = selectedToVideos
            destination.dateText = selectedDateText
            
        }
        
    }
    
}
