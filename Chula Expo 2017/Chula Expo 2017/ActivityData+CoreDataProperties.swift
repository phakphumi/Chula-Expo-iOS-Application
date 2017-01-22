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
    
}
