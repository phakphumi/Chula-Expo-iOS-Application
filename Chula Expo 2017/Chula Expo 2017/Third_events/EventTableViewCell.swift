//
//  EventTableViewCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell
{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var activityId: String?
    var desc: String?
    var bannerUrl: String?
    var isHighlight: Bool?
    var isFavorite: Bool?
    var reservable: Bool?
    var isReserve: Bool?
    var toTags: NSSet?
    var toFaculty: String?
    var toImages: NSSet?
    var toVideos: String?
    var dateText: String?
    
    var name: String?
    {
        didSet
        {
            updateUI()
        }
    }
    var startTime: NSDate?
    {
        didSet
        {
            updateUI()
        }
    }
    var endTime: NSDate?
        {
        didSet
        {
            updateUI()
        }
    }
    var locationDesc: String?
    {
        didSet
        {
            updateUI()
        }
    }
    
    
    private func updateUI()
    {
        //Reset
        nameLabel.text = nil
        timeLabel.text = nil
        locationLabel.text = nil
        
        
        if let eventName = name
        {
            nameLabel.text = eventName
        }
        if let eventStartTime = startTime
        {
            if let eventEndTime = endTime{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "H:mm"
                let sTime = dateFormatter.string(from: eventStartTime as Date)
                let eTime = dateFormatter.string(from: eventEndTime as Date)
                timeLabel.text = "\(sTime) - \(eTime)"
            }
        }
        if let eventLocationDesc = locationDesc
        {
            locationLabel.text = eventLocationDesc
        }
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

