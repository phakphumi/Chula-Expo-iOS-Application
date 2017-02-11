//
//  EventFeedCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

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
    fileprivate var loadedImage: UIImage? {
        
        didSet {
            eventTumbnailImage.image = loadedImage
        }
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
//            let fac = facity as! FacultyData
//            let cap = getCapsule(forFacity: fac.name!)
//            facityCapsule.text = cap.facText
//            facityCapsule.backgroundColor = cap.facColor
//            facityCapsule.layer.cornerRadius = facityCapsule.bounds.height/4.5
//            facityCapsule.layer.masksToBounds = true
        }
    }
    
    func getCapsule(forFacity facity: String) -> FacityCap{
        
        
        switch facity {
        case "Faculty of Engineering":
            return FacityCap(facText: "ENG", facColor: UIColor(red: 0.61, green: 0.00, blue: 0.01, alpha: 1))
        default:
            return FacityCap(facText: "Def", facColor: UIColor.black)
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        cardStyle(background: background)
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
