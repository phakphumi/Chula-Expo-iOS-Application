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

    var name: String?{
        didSet{
            updateUI()
            eventName.sizeToFit()
        }
    }
    var sTime: NSDate?{
        didSet{
            updateUI()
            startTime.sizeToFit()
        }
    }
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    
    private func updateUI(){
        eventName.text = nil
        startTime.text = nil
        
        
        if let name1 = name{
            eventName.text = name1
        }
        if let start = sTime{
            if start.isToday()
            {
                self.startTime.text = "TODAY"
            }
            else if start.isTomorrow()
            {
                self.startTime.text = "TOMORROW"
            }
            else if start.isYesterday()
            {
                self.startTime.text = "YESTERDAY"
            }
            else
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, EEE H m"
                self.startTime.text = dateFormatter.string(from: start as Date)
            }
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
