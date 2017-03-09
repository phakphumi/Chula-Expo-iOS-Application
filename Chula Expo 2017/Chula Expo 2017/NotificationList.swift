//
//  NotificationList.swift
//  Chula Expo 2017
//
//  Created by NOT on 3/9/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import Foundation
import UIKit

class NotificationList {
    
    struct NotiItem {
        var title: String
        var deadline: Date
        var UUID: String
        
        init(deadline: Date, title: String, UUID: String) {
            self.deadline = deadline
            self.title = title
            self.UUID = UUID
        }
    }
    
    class var sharedInstance : NotificationList {
        struct Static {
            static let instance: NotificationList = NotificationList()
        }
        return Static.instance
    }
    
    
    fileprivate let ITEMS_KEY = "notificationItems"
    func addItem(_ item: NotiItem) {
        // persist a representation of this todo item in UserDefaults
        var todoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        todoDictionary[item.UUID] = ["deadline": item.deadline, "title": item.title, "UUID": item.UUID] // store NSData representation of todo item in dictionary with UUID as key
        UserDefaults.standard.set(todoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item \"\(item.title)\" Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = item.deadline as Date // todo item due date (when notification will be fired) notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": item.title, "UUID": item.UUID] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
}
