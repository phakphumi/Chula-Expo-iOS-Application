//
//  EventsTableViewController.swift
//  Chula Expo 2017
//
//  Created by PANUPONG TONGTAWACH on 1/7/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventsTableViewController: CoreDataTableViewController {
    
    var facity: String? {
        didSet {
            updateData()
        }
    }
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            updateData()
        }
    }
    
    fileprivate func updateData() {
        
        if let facity = facity {
            
            if let context = managedObjectContext, (facity.characters.count) > 0 {
            
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            
                if facity == "Favorite" {
                    
                    title = "MY FAVORITE"
                    request.predicate = NSPredicate(format: "ANY toRound.isFavorite == %@", NSNumber(booleanLiteral: true))
                    
                }

                else if facity == "Reservation" {
                    
                    title = "MY RESERVATION"
                    request.predicate = NSPredicate(format: "ANY toRound.isReserve == %@", NSNumber(booleanLiteral: true))
                    
                }
                
                else {
                    
                request.predicate = NSPredicate(format: "faculty contains[c] %@", facity)
                    
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            
            if let headCell = cell as? HeaderTableViewCell {
                
                if tableView.numberOfRows(inSection: 0) == 1 {
                    
                    if facity == "Reservation"{
                        
                        headCell.title1 = "NOT HAVE RESERVATION"
                        headCell.title2 = "ไม่มีบันทึกการจองกิจกรรมที่สนใจ"
                        headCell.iconImage = "crossIcon"
                    }
                    else if facity == "Favorite"{
                        
                        headCell.title1 = "NOT HAVE FAVORITE EVENTS"
                        headCell.title2 = "คุณยังไม่ได้เพิ่มกิจกรรมที่สนใจ"
                        headCell.iconImage = "crossIcon"
                    }
                    else{
                        
                        headCell.title1 = "EVENT NOT FOUND!"
                        headCell.title2 = "ไม่พบกิจกรรมที่เกี่ยวข้อง"
                        headCell.iconImage = "crossIcon"
                    }
                    
                } else {
                    
                    headCell.title1 = "RELATED EVENTS"
                    headCell.title2 = "กิจกรรมที่เกี่ยวข้อง"
                    headCell.iconImage = "relatedeventsIcon"
                }
            }
        }
        
        else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
            
            if let fetchData = fetchedResultsController?.object(at: IndexPath(row: indexPath.row - 1, section: 0)) as? ActivityData {
                
                var activityId: String?
                var name: String?
                var toRound: NSSet?
                var thumbnail: String?
                
                fetchData.managedObjectContext?.performAndWait {
                    
                    name = fetchData.name
                    toRound = fetchData.toRound
                    thumbnail = fetchData.thumbnailsUrl
                    activityId = fetchData.activityId
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "toDetail" {
            
            if let destination = segue.destination as? EventDetailTableViewController{
                
                if let eventcell = sender as? EventFeedCell?{
                    
                    if let id = eventcell?.activityId{
                        
                        ActivityData.fetchActivityData(activityId: id, inManageobjectcontext: managedObjectContext!, completion: { (activityData) in
                            
                            if let activityData = activityData {
                                
                                destination.activityId = activityData.activityId
                                destination.bannerUrl = activityData.bannerUrl
                                destination.topic = activityData.name
                                destination.locationDesc = ""
                                destination.toRounds = activityData.toRound
                                destination.desc = activityData.desc
                                destination.room = activityData.room
                                destination.place = activityData.place
                                destination.latitude = activityData.latitude
                                destination.longitude = activityData.longitude
                                destination.pdf = activityData.pdf
                                destination.toImages = activityData.toImages
                                destination.toTags = activityData.toTags
                                destination.managedObjectContext = self.managedObjectContext
                                
                            }
                            
                        })

                    }
                }
            }
        }
        
    }
    
}
