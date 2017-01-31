//
//  RoundData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData


extension RoundData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoundData> {
        return NSFetchRequest<RoundData>(entityName: "RoundData");
    }

    @NSManaged public var activityId: String?
    @NSManaged public var endTime: NSDate?
    @NSManaged public var fullCapacity: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var isHighlight: Bool
    @NSManaged public var isReserve: Bool
    @NSManaged public var reservable: Bool
    @NSManaged public var reserved: Int16
    @NSManaged public var roundNo: Int16
    @NSManaged public var seatAvaliable: Int16
    @NSManaged public var startTime: NSDate?
    @NSManaged public var toActivity: ActivityData?
    
    var dateSection: String
        {
        get
        {
            if self.startTime!.isToday()
            {
                return "TODAY"
            }
            else if self.startTime!.isTomorrow()
            {
                return "TOMORROW"
            }
            else if self.startTime!.isYesterday()
            {
                return "YESTERDAY"
            }
            else
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, EEE H m"
                return dateFormatter.string(from: startTime! as Date)
            }
        }
    }
    
    var dateText: String
        {
        get
        {
            if self.startTime!.isToday()
            {
                return "Today"
            }
            else if self.startTime!.isTomorrow()
            {
                return "Tomorrow"
            }
            else if self.startTime!.isYesterday()
            {
                return "Yesterday"
            }
            else
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, EEE"
                return dateFormatter.string(from: startTime! as Date)
            }
        }
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

