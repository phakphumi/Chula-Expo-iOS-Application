//
//  ActivityData+CoreDataProperties.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/23/2560 BE.
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
    @NSManaged public var isStageEvent: Bool
    @NSManaged public var locationDesc: String?
    @NSManaged public var name: String?
    @NSManaged public var stageNo: Int16
    @NSManaged public var thumbnailsUrl: String?
    @NSManaged public var toFaculty: NSSet?
    @NSManaged public var toImages: NSSet?
    @NSManaged public var toRound: NSSet?
    @NSManaged public var toTags: NSSet?
    @NSManaged public var toVideos: NSSet?

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

// MARK: Generated accessors for toRound
extension ActivityData {

    @objc(addToRoundObject:)
    @NSManaged public func addToToRound(_ value: RoundData)

    @objc(removeToRoundObject:)
    @NSManaged public func removeFromToRound(_ value: RoundData)

    @objc(addToRound:)
    @NSManaged public func addToToRound(_ values: NSSet)

    @objc(removeToRound:)
    @NSManaged public func removeFromToRound(_ values: NSSet)

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
