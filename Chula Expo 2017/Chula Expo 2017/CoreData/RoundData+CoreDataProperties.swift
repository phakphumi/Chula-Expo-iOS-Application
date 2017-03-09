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
    @NSManaged public var endTime: Date?
    @NSManaged public var fullCapacity: Int16
    @NSManaged public var id: String?
    @NSManaged public var reserved: Int16
    @NSManaged public var seatAvaliable: Int16
    @NSManaged public var startTime: Date?
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




extension Date {
    
    static var day1 = Date.from(year: 2017, month: 3, day: 15)
    static var day2 = Date.from(year: 2017, month: 3, day: 16)
    static var day3 = Date.from(year: 2017, month: 3, day: 17)
    static var day4 = Date.from(year: 2017, month: 3, day: 18)
    static var day5 = Date.from(year: 2017, month: 3, day: 19)
    static var day6 = Date.from(year: 2017, month: 3, day: 20)
    
    static func from(year: Int, month: Int, day: Int) -> Date {
        
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    static func from(year: Int, month: Int, day: Int, hour: Int, minuite: Int) -> Date {
        
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minuite
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    func toThaiText() -> String{
        
        let day = NSCalendar.current.component(.day, from: self)
        let month = NSCalendar.current.component(.month, from: self)
        let year = NSCalendar.current.component(.year, from: self)
        let hour = NSCalendar.current.component(.hour, from: self)
        let minuite = NSCalendar.current.component(.minute, from: self)
        
        var minuiteText = "\(minuite)"
        if minuite < 10{
            minuiteText = "0\(minuite)"
        }
        
        var monthText = ""
        
        switch month {
        case 1:
            monthText = "มกราคม"
        case 2:
            monthText = "กุมภาพันธ์"
        case 3:
            monthText = "มีนาคม"
        case 4:
            monthText = "เมษายน"
        case 5:
            monthText = "มิถุนายน"
        default:
            monthText = "ธันวาคม"
        }
        
        return ("\(day) \(monthText) \(year) • \(hour):\(minuiteText)")
    }
    
    func toThaiText(withEnd end: Date) -> String{
        
        let calendar = NSCalendar.current
        
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let hour = calendar.component(.hour, from: self)
        let minuite = calendar.component(.minute, from: self)
        let endDay = calendar.component(.day, from: end)
        let endHour = calendar.component(.hour, from: end)
        let endMin = calendar.component(.minute, from: end)
        
        var minuiteText = "\(minuite)"
        if minuite < 10{
            minuiteText = "0\(minuite)"
        }
        
        var endMinuiteText = "\(endMin)"
        if endMin < 10{
            endMinuiteText = "0\(endMin)"
        }
        var monthText = ""
        
        switch month {
        case 1:
            monthText = "มกราคม"
        case 2:
            monthText = "กุมภาพันธ์"
        case 3:
            monthText = "มีนาคม"
        case 4:
            monthText = "เมษายน"
        case 5:
            monthText = "มิถุนายน"
        default:
            monthText = "ธันวาคม"
        }
        var dayText = "\(day)"
        
        if endDay != day {
            if day == 15 && endDay == 19{
                dayText = "ทุกวัน"
                return ("\(dayText) • \(hour):\(minuiteText)-\(endHour):\(endMinuiteText)")
                
            } else {
            dayText = ("\(dayText)-\(endDay)")
            }
        }
        
        return ("\(dayText) \(monthText) \(year) • \(hour):\(minuiteText)-\(endHour):\(endMinuiteText)")
    }

    
    func toThaiTextOnlyDate(withEnd end: Date) -> String{
        
        let calendar = NSCalendar.current

        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let endDay = calendar.component(.day, from: end)
        
        var monthText = ""
        
        switch month {
        case 1:
            monthText = "มกราคม"
        case 2:
            monthText = "กุมภาพันธ์"
        case 3:
            monthText = "มีนาคม"
        case 4:
            monthText = "เมษายน"
        case 5:
            monthText = "มิถุนายน"
        default:
            monthText = "ธันวาคม"
        }
        var dayText = "\(day)"
        
        if endDay != day {
            if day == 15 && endDay == 19{
                dayText = "ทุกวัน"
                return ("    \(dayText)")
                
            } else {
                dayText = ("\(dayText)-\(endDay)")
            }
        }
        
        return ("\(dayText) \(monthText)")
    }

    
    func toTimeText() -> String{
        
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: self)
        let minuite = calendar.component(.minute, from: self)
        
        var minuiteText = "\(minuite)"
        if minuite < 10{
            minuiteText = "0\(minuite)"
        }
        
        return ("\(hour):\(minuiteText)")
    }
    
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    func isToday() -> Bool{
        var isToday = false
        
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 0, to: Date())!)
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, EEE H m"
//        print("TODAY == \(dateFormatter.string(from: today))")
//        print("TOMORROW == \(dateFormatter.string(from: tomorrow))")
        
        
        if(self.isLessThanDate(tomorrow)){
            print("PASS1")
            if(self.isGreaterThanDate(today) || self.equalToDate(today)){
                isToday = true
//                print("PASS2")
            }
//            print("MISS2")
        }
//        print("MISS1")
        return isToday
    }
    
    func isTomorrow() -> Bool{
        var isTomorrow = false
        
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        let twoDayAfter = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 2, to: Date())!)
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
        
        if(self.isLessThanDate(twoDayAfter)){
            if(self.isGreaterThanDate(tomorrow) || self.equalToDate(tomorrow)){
                isTomorrow = true
            }
        }
        return isTomorrow
    }
    
    func isYesterday() -> Bool{
        var isYesterday = false
        
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 0, to: Date())!)
        let yesterday = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -1, to: Date())!)
        
        if(self.isLessThanDate(today)){
//            print("PASS1")
            if(self.isGreaterThanDate(yesterday) || self.equalToDate( yesterday)){
                isYesterday = true
//                print("PASS2")
            }
        }
        return isYesterday
    }
    
    func isInRangeOf(start: Date?, end: Date?) -> Bool{
        
        if (start == nil || end == nil){
            return false
        }
//        print("condition \(start!.toThaiText()) - \(end!.toThaiText()) compareto \(self.toThaiText()))")
        return self.isLessThanDate(end!) && (self.isGreaterThanDate(start!) || self.equalToDate(start!))
        
    }
    
    func checkInday() -> Int{
        
        if self.isInRangeOf(start: Date.day1, end: Date.day2){
            return 1
        }
        else if self.isInRangeOf(start: Date.day2, end: Date.day3){
            return 2
        }
        else if self.isInRangeOf(start: Date.day3, end: Date.day4){
            return 3
        }
        else if self.isInRangeOf(start: Date.day4, end: Date.day5){
            return 4
        }
        else if self.isInRangeOf(start: Date.day5, end: Date.day6){
            return 5
        }
        
        return 0
    }
}

