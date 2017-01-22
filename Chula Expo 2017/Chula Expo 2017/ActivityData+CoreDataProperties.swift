//
//  ActivityData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/22/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import CoreData


extension ActivityData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityData> {
        return NSFetchRequest<ActivityData>(entityName: "ActivityData");
    }
    
    @NSManaged public var activityId: String?
    @NSManaged public var bannerUrl: String?
    @NSManaged public var desc: String?
    @NSManaged public var endTime: NSDate?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var isHighlight: Bool
    @NSManaged public var isReserve: Bool
    @NSManaged public var isStageEvent: Bool
    @NSManaged public var stageNo: Int16
    @NSManaged public var locationDesc: String?
    @NSManaged public var name: String?
    @NSManaged public var reservable: Bool
    @NSManaged public var startTime: NSDate?
    @NSManaged public var thumbnailsUrl: String?
    @NSManaged public var toImages: NSSet?
    @NSManaged public var toTags: NSSet?
    @NSManaged public var toVideos: NSSet?
    @NSManaged public var toFaculty: NSSet?
    
}

// MARK: Generated accessors for toImages
extension ActivityData {
    
    @objc(addToImagesObject:)
    @NSManaged public func addToToImages(_ value: ImageData)
    
    @objc(removeToImagesObject:)
    @NSManaged public func removeFromToImages(_ value: ImageData)
    
    @objc(addToImages:)
    @NSManaged public func addToToImages(_ values: NSSet)
    
    @objc(removeToImages:)
    @NSManaged public func removeFromToImages(_ values: NSSet)
    
}

// MARK: Generated accessors for toTags
extension ActivityData {
    
    @objc(addToTagsObject:)
    @NSManaged public func addToToTags(_ value: TagData)
    
    @objc(removeToTagsObject:)
    @NSManaged public func removeFromToTags(_ value: TagData)
    
    @objc(addToTags:)
    @NSManaged public func addToToTags(_ values: NSSet)
    
    @objc(removeToTags:)
    @NSManaged public func removeFromToTags(_ values: NSSet)
    
}

// MARK: Generated accessors for toVideos
extension ActivityData {
    
    @objc(addToVideosObject:)
    @NSManaged public func addToToVideos(_ value: VideoData)
    
    @objc(removeToVideosObject:)
    @NSManaged public func removeFromToVideos(_ value: VideoData)
    
    @objc(addToVideos:)
    @NSManaged public func addToToVideos(_ values: NSSet)
    
    @objc(removeToVideos:)
    @NSManaged public func removeFromToVideos(_ values: NSSet)
    
}

// MARK: Generated accessors for toFaculty
extension ActivityData {
    
    @objc(addToFacultyObject:)
    @NSManaged public func addToToFaculty(_ value: FacultyData)
    
    @objc(removeToFacultyObject:)
    @NSManaged public func removeFromToFaculty(_ value: FacultyData)
    
    @objc(addToFaculty:)
    @NSManaged public func addToToFaculty(_ values: NSSet)
    
    @objc(removeToFaculty:)
    @NSManaged public func removeFromToFaculty(_ values: NSSet)
    
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

