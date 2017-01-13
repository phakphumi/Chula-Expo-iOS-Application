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

extension NSDate
{
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    func isToday() -> Bool{
        var isToday = false
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 0, to: Date())!)
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, EEE H m"
        print("TODAY == \(dateFormatter.string(from: today))")
        print("TOMORROW == \(dateFormatter.string(from: tomorrow))")
        
        
        if(self.isLessThanDate(dateToCompare: tomorrow)){
            print("PASS1")
            if(self.isGreaterThanDate(dateToCompare: today) || self.equalToDate(dateToCompare: today)){
                isToday = true
                print("PASS2")
            }
            print("MISS2")
        }
        print("MISS1")
        return isToday
    }
    
    func isTomorrow() -> Bool{
        var isTomorrow = false
        
        let calendar = Calendar.current
        
        let twoDayAfter = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 2, to: Date())!)
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
        
        if(self.isLessThanDate(dateToCompare: twoDayAfter)){
            if(self.isGreaterThanDate(dateToCompare: tomorrow) || self.equalToDate(dateToCompare: tomorrow)){
                isTomorrow = true
            }
        }
        return isTomorrow
    }
    
    func isYesterday() -> Bool{
        var isYesterday = false
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 0, to: Date())!)
        let yesterday = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -1, to: Date())!)
        
        if(self.isLessThanDate(dateToCompare: today)){
            print("PASS1")
            if(self.isGreaterThanDate(dateToCompare: yesterday) || self.equalToDate(dateToCompare: yesterday)){
                isYesterday = true
                print("PASS2")
            }
        }
        return isYesterday
    }
}
