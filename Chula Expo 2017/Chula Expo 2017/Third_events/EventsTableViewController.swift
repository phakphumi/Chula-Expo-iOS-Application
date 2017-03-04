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
    
    var interestDesc: String?
    
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            updateData()
        }
    }
    
    var facityBanner: String?
    var facityName: String?
    var facityDesc: String?
    
    var isFaculty = false
    var isInterest = false
    
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
                
                else if isInterest {
                    
                     request.predicate = NSPredicate(format: "ANY toTags.name == %@", facity)
                }
                
                else {
                    
                    request.predicate = NSPredicate(format: "faculty contains[c] %@", facity)

                }
                
                request.sortDescriptors = [NSSortDescriptor(
                    key: "start",
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
        
        tableView.estimatedRowHeight = 300
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.tabBarController?.tabBar.isTranslucent = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.tabBarController?.tabBar.isTranslucent = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
           
            if isFaculty{
                cell = tableView.dequeueReusableCell(withIdentifier: "facBanner", for: indexPath)
                if let bannercell = cell as? FacultyBannerCell{
                    
                    var bannerURL: String?
                    managedObjectContext?.performAndWait {
                        if let facityID = self.facity{
                            
                            bannerURL = ZoneData.fetchZoneBannerFrom(id: facityID, incontext: self.managedObjectContext!)
                            
                        }
                    }
                    
                    bannercell.bannerUrl = bannerURL
                    
                }
            }
        }
        else if indexPath.row == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "facDesc", for: indexPath)
            
            
                
            if let descCell = cell as? FacultyDescCell{
                var name: String?
                var desc: String?
                if isInterest {
                    desc = interestDesc
                    name = facity
                }else{
                    managedObjectContext?.performAndWait {
                        if let facityID = self.facity{
                            
                            name = ZoneData.fetchZoneNameFrom(id: facityID, incontext: self.managedObjectContext!)
                            desc = ZoneData.fetchZoneDescFrom(id: facityID, incontext: self.managedObjectContext!)
                            
                        }
                    }
                }
                descCell.facityDesc = desc
                descCell.facityTitle = name
            }
        }
        
        else if indexPath.row == 2 {
            
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
            
            
            if let fetchData = fetchedResultsController?.object(at: IndexPath(row: indexPath.row - 3, section: 0)) as? ActivityData{
                
                var name: String?
                var thumbnail: String?
                var toRound: NSSet?
                var facity: String?
                var activityId: String?
                var time: String?
                
                fetchData.managedObjectContext?.performAndWait{
                    name = fetchData.name
                    thumbnail = fetchData.thumbnailsUrl
                    facity = fetchData.faculty
                    toRound = fetchData.toRound
                    
                    activityId = fetchData.activityId
                    if let stime = fetchData.start{
                        if let eTime = fetchData.end{
                            time = stime.toThaiText(withEnd: eTime)
                        }
                    }
                    if let toRound = toRound{
                        if time != nil{
                            if toRound.count > 0 {
                                time = ("\(time!) + \(toRound.count) รอบ")
                            }
                        }
                    }
                }
                
                if let eventFeedCell = cell as? EventFeedCell{
                    eventFeedCell.manageObjectContext = managedObjectContext
                    if name != nil{
                        eventFeedCell.name = name
                    }
                    if time != nil{
                        eventFeedCell.timeText = time
                    }
                    eventFeedCell.eventTumbnailImage.image = #imageLiteral(resourceName: "defaultImage")
                    eventFeedCell.thumbnail = thumbnail
                    eventFeedCell.facity = facity
                    eventFeedCell.activityId = activityId
                    eventFeedCell.toRound = toRound
                }
            }
        }
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       if indexPath.section == 0{
            
            if indexPath.row == 0{
                if isFaculty == true {
                    return UITableViewAutomaticDimension
                }
                return 0
            }
            else if indexPath.row == 1{
            
                return UITableViewAutomaticDimension
            }
            else if indexPath.row == 2{
                
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
                                destination.zoneId = activityData.faculty
                                destination.latitude = activityData.latitude
                                destination.longitude = activityData.longitude
                                destination.pdf = activityData.pdf
                                destination.toImages = activityData.toImages
                                destination.toTags = activityData.toTags
                                destination.managedObjectContext = self.managedObjectContext
                                
                                
                                print(destination.toRounds)
                            }
                            
                        })

                    }
                }
            }
        }
        
    }
    
}
