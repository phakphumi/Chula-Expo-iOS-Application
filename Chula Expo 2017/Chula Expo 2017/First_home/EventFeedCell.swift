//
//  EventFeedCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventFeedCell: UITableViewCell {

    @IBOutlet weak var eventTumbnailImage: UIImageView!{
        didSet{
            cardStyle(background: background)
        }
    }
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet var facityCapsule: CapsuleUILabel!
    
    struct FacityCap {
        var facText: String
        var facColor: UIColor
    }
    
    var activityId: String?
    var timeText: String?{
        didSet{
            if let text = timeText{
                
                eventTimeLabel.text = text
            }
        }
    }
    var name: String?{
        didSet{
           eventNameLabel.text = name
        }
    }
    var thumbnail: String?{
        didSet{
            eventTumbnailImage.imageFromServerURL(urlString: thumbnail!)
        }
    }
//    var toRound: NSSet?{
//        didSet{
//            if let rounds = toRound{
//                if let round = rounds.allObjects.first as! RoundData?{
//                    let eventDate = round.dateText
//                    let eventStartTime = round.startTime!
//                    let eventEndTime = round.endTime!
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "H:mm"
//                    let sTime = dateFormatter.string(from: eventStartTime as Date)
//                    let eTime = dateFormatter.string(from: eventEndTime as Date)
//                    eventTimeLabel.text = "\(eventDate) • \(sTime)-\(eTime)"
//                }
//            }
//        }
//    }
    
    var facity: String?{
        didSet{
            updateUI()
        }
    }
    
    var date: String?{
        didSet{
//            updateUI()
        }
    }
    var manageObjectContext: NSManagedObjectContext?{
        didSet{
            updateUI()
        }
    }
    
//    override func layoutSubviews() {
//        
//        super.layoutSubviews()
//        cardStyle(background: background)
//    }
    
    func updateUI(){

        if manageObjectContext != nil{
            if let eventFacity = facity{
                getFacultyFrom(id: eventFacity)
            }
        }
        
    }
    
    func getFacultyFrom(id: String){
        
        if let context = manageObjectContext{
            context.performAndWait {
                if let zoneDetail = ZoneData.fetchZoneDetail(zoneId: id, inManageobjectcontext: context){
                    self.facityCapsule.setText(name: (zoneDetail.shortName)!)
                }
            }
        }
    }
    
}

extension UIImageView {
    
    public func imageFromServerURL(urlString: String) {
        
        if urlString == ""{
            if self.bounds.width > 200 || self.bounds.height > 200 {
                
                self.image = #imageLiteral(resourceName: "defaultBig")
            }
            else{
                
                self.image = #imageLiteral(resourceName: "defaultImage")
            }
            return
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                if self.bounds.width > 200 || self.bounds.height > 200 {
                    
                    self.image = #imageLiteral(resourceName: "defaultBig")
                }
                else{
                    
                    self.image = #imageLiteral(resourceName: "defaultImage")
                }
                
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if let image = UIImage(data: data!){
                    self.image = image
                }
                else{
                    self.image = UIImage(named: "defaultImage")
                }
            })
            
        }).resume()
    }
}
