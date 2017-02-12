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

    @IBOutlet weak var eventTumbnailImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet var facityCapsule: CapsuleUILabel!
    
    struct FacityCap{
        var facText: String
        var facColor: UIColor
    }
    
    var name: String?{
        didSet{
            print("\(name)")
            updateUI()
        }
    }
    var thumbnail: String?{
        didSet{
            thumbnail = "http://staff.chulaexpo.com" + thumbnail!
            eventTumbnailImage.imageFromServerURL(urlString: thumbnail!)
        }
    }
    var toRound: NSSet?{
        didSet{
            updateUI()
        }
    }
    var facity: String?{
        didSet{
            updateUI()
        }
    }
    var date: String?{
        didSet{
            updateUI()
        }
    }
    var manageObjectContext: NSManagedObjectContext?{
        didSet{
            updateUI()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        cardStyle(background: background)
    }
    
    func updateUI(){
        // reset
        eventNameLabel.text = nil
        eventTimeLabel.text = nil
        
        
        if let rounds = toRound{
            if let round = rounds.allObjects.first as! RoundData?{
                let eventDate = round.dateText
                let eventStartTime = round.startTime!
                let eventEndTime = round.endTime!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "H:mm"
                let sTime = dateFormatter.string(from: eventStartTime as Date)
                let eTime = dateFormatter.string(from: eventEndTime as Date)
                eventTimeLabel.text = "\(eventDate) • \(sTime)-\(eTime)"
            }
        }
        if let eventName = name{
            eventNameLabel.text = eventName
        }
        
        if let eventFacity = facity{
            
            getFacultyFrom(id: eventFacity)
//            let fac = facity as! FacultyData
//            let cap = getCapsule(forFacity: fac.name!)
//            facityCapsule.text = cap.facText
//            facityCapsule.backgroundColor = cap.facColor
//            facityCapsule.layer.cornerRadius = facityCapsule.bounds.height/4.5
//            facityCapsule.layer.masksToBounds = true
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
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
