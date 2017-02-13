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
    
//    var selectedActivityId: String?
//    var selectedName: String?
//    var selectedStartTime: NSDate?
//    var selectedEndTime: NSDate?
//    var selectedLocationDesc: String?
//    var selectedDesc: String?
//    var selectedBannerUrl: String?
//    var selectedIsHighlight: Bool?
//    var selectedIsFavorite: Bool?
//    var selectedReservable: Bool?
//    var selectedIsReserve: Bool?
//    var selectedToTags: NSSet?
//    var selectedToFaculty: String?
//    var selectedToImages: NSSet?
//    var selectedToVideos: NSSet?
//    var selectedDateText: String?
    
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
        if let facity = facity{
            
        if let context = managedObjectContext, (facity.characters.count) > 0 {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            
            if facity == "Favourites" {
                
                request.predicate = NSPredicate(format: "toRound.isFavorite == %@", NSNumber(booleanLiteral: true))
            }
                
            else if facity == "Reservations" {
                
                request.predicate = NSPredicate(format: "toRound.isReserve == %@", NSNumber(booleanLiteral: true))
            }
                
            else {
                request.predicate = NSPredicate(format: "any faculty contains[c] %@", facity)
            }
            
            request.sortDescriptors = [NSSortDescriptor(
                key: "activityId",
                ascending: true
//                selector: #selector(NSDate.compare(_:))
                )]
            
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
//                sectionNameKeyPath: "toRound.dateSection",
                cacheName: nil
            )
            }
        }
            
        else {
            
            fetchedResultsController = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell()
        
        if indexPath.row == 0{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            
            if let headCell = cell as? HeaderTableViewCell{
                
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
            
            if let fetchData = fetchedResultsController?.object(at: IndexPath(row: indexPath.row - 1, section: 0)) as? ActivityData {
                
                var activityId: String?
//                var desc: String?
//                var bannerUrl: String?
//                var isHighlight: Bool?
//                var isFavorite: Bool?
//                var reservable: Bool?
//                var isReserve: Bool?
//                var toTags: NSSet?
//                var toFaculty: String?
//                var toImages: NSSet?
//                var toVideos: String?
//                var dateText: String?
                var name: String?
                var toRound: NSSet?
                var thumbnail: String?
//                var locationDesc: String?
                
                fetchData.managedObjectContext?.performAndWait {
                        // it's easy to forget to do this on the proper queue
                        
                        name = fetchData.name
                        toRound = fetchData.toRound
                        thumbnail = fetchData.thumbnailsUrl
//                        locationDesc = ""
                        
                        activityId = fetchData.activityId
//                      desc = fetchData.desc
//                      bannerUrl = fetchData.bannerUrl
//                      isHighlight = fetchData.isHighlight
//                      isFavorite = fetchData.isFavorite
//                      reservable = fetchData.reservable
//                      isReserve = fetchData.isReserve
//                      toTags = fetchData.toTags
//                      toFaculty = fetchData.faculty
//                      toImages = fetchData.toImages
//                      toVideos = fetchData.video
//                      dateText = fetchData.dateText
                       
                }
                if let eventCell = cell as? EventFeedCell {
                    
                    eventCell.manageObjectContext = managedObjectContext
                    eventCell.name = name
                    eventCell.toRound = toRound
                    eventCell.thumbnail = thumbnail
                    eventCell.facity = facity
                    eventCell.activityId = activityId
                }
            }

        }
        
        // Configure the cell...
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       if indexPath.section == 0{
            
            if indexPath.row == 0{
                
                return 58
            }
            
            return 78
        }
        
        return UITableViewAutomaticDimension
        
    }


//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let currentCell = tableView.cellForRow(at: indexPath) as? EventTableViewCell
//        
//        selectedActivityId = currentCell?.activityId
//        selectedName = currentCell?.name
//        selectedStartTime = currentCell?.startTime
//        selectedEndTime = currentCell?.endTime
//        selectedLocationDesc = currentCell?.locationDesc
//        selectedDesc = currentCell?.desc
//        selectedBannerUrl = currentCell?.bannerUrl
//        selectedIsHighlight = currentCell?.isHighlight
//        selectedIsFavorite = currentCell?.isFavorite
//        selectedReservable = currentCell?.reservable
//        selectedIsReserve = currentCell?.isReserve
//        selectedToTags = currentCell?.toTags
//        selectedToFaculty = currentCell?.toFaculty
//        selectedToImages = currentCell?.toImages
//        selectedToVideos = currentCell?.toVideos
//        selectedDateText = currentCell?.dateText
//            
//        self.performSegue(withIdentifier: "toEventDetails", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEventDetail" {
            
            if let destination = segue.destination as? EventDetailTableViewController{
                
                if let eventcell = sender as? EventFeedCell?{
                    
                    if let id = eventcell?.activityId{
                        
                        if let fetch = ActivityData.fetchActivityDetails(activityId: id, inManageobjectcontext: managedObjectContext!){
                            
                            destination.bannerUrl = fetch.bannerUrl
                            destination.topic = fetch.name
                            destination.locationDesc = ""
                            destination.toRounds = fetch.toRound
                            destination.reservable = fetch.reservable
                            destination.desc = fetch.desc
                            destination.room = fetch.room
                            destination.place = fetch.place
                            destination.latitude = fetch.latitude
                            destination.longitude = fetch.longitude
                            destination.toImages = fetch.toImages
                            destination.toTags = fetch.toTags
                            destination.managedObjectContext = self.managedObjectContext
                        }
                    }
                }

                else if let eventcell = sender as? EventTableViewCell?{
                    
                    if let id = eventcell?.activityId{
                        
                        if let fetch = ActivityData.fetchActivityDetails(activityId: id, inManageobjectcontext: managedObjectContext!){
                            
                            destination.bannerUrl = fetch.bannerUrl
                            destination.topic = fetch.name
                            destination.locationDesc = ""
                            destination.toRounds = fetch.toRound
                            destination.reservable = fetch.reservable
                            destination.desc = fetch.desc
                            destination.room = fetch.room
                            destination.place = fetch.place
                            destination.latitude = fetch.latitude
                            destination.longitude = fetch.longitude
                            destination.toImages = fetch.toImages
                            destination.toTags = fetch.toTags
                            destination.managedObjectContext = self.managedObjectContext
                            
//                            destination.activityId = fetch.activityId
//                            destination.name = fetch.name
//                            destination.startTime = NSDate()
//                            destination.endTime = NSDate()
//                            destination.locationDesc = fetch.locationDesc
//                            destination.desc = fetch.desc
//                            destination.bannerUrl = fetch.bannerUrl
//                            destination.isHighlight = false
//                            destination.isFavorite = false
//                            destination.reservable = true
//                            destination.isReserve = false
//                            destination.toTags = fetch.toTags
//                            destination.toFaculty = fetch.toFaculty
//                            destination.toImages = fetch.toImages
//                            destination.toVideos = fetch.toVideos
//                            destination.dateText = "Today"
                        }
                    }
                }
            }
        }
    }
}
