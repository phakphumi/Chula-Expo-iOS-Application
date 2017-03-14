//
//  MeViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/9/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CoreData
import Foundation
import Answers

class MeViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var profileImg: UIImageView!

    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet var aboutAppView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var editfacView: UIView!
    @IBOutlet weak var edittagView: UIView!
    @IBOutlet weak var reserveView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var proView: UIView!
    @IBOutlet weak var editproButton: UIButton!
    
    @IBAction func qr(_ sender: Any) {
        
        if UserData.isThereUser(inManageobjectcontext: self.managedObjectContext!) {
            
            tabBarController?.performSegue(withIdentifier: "toQRCode", sender: tabBarController)
            
        } else {
            
            let confirm = UIAlertController(title: "ข้อผิดพลาด", message: "ฟังก์ชัน QR Code เปิดให้ใช้งานได้เฉพาะผู้ใช้ที่ลงทะเบียนผ่าน Facebook เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "เข้าสู่ระบบด้วย Facebook", style: UIAlertActionStyle.default, handler: { (alert) in
                
                self.tabBarController?.performSegue(withIdentifier: "logout", sender: self)
                
            }))
            confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.destructive, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func aboutUs(_ sender: UIButton) {
        
        let aboutView = storyboard?.instantiateViewController(withIdentifier: "aboutUs") as? AboutViewController
        
        tabBarController?.present(aboutView!, animated: true, completion: nil)
        
    }

   
    @IBAction func editInformation(_ sender: UIButton) {

        if UserData.isThereUser(inManageobjectcontext: self.managedObjectContext!) {
            
            tabBarController?.performSegue(withIdentifier: "editInfo", sender: self)
            
        } else {
            
            let confirm = UIAlertController(title: "ข้อผิดพลาด", message: "ฟังก์ชัน QR Code เปิดให้ใช้งานได้เฉพาะผู้ใช้ที่ลงทะเบียนผ่าน Facebook เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "เข้าสู่ระบบด้วย Facebook", style: UIAlertActionStyle.default, handler: { (alert) in
                
                self.tabBarController?.performSegue(withIdentifier: "logout", sender: self)
                
            }))
            confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.destructive, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }

    @IBAction func editTag(_ sender: UIButton) {
        
        if UserData.isThereUser(inManageobjectcontext: self.managedObjectContext!) {
            
            tabBarController?.performSegue(withIdentifier: "editTag", sender: self)
            
        } else {
            
            let confirm = UIAlertController(title: "ข้อผิดพลาด", message: "ฟังก์ชัน QR Code เปิดให้ใช้งานได้เฉพาะผู้ใช้ที่ลงทะเบียนผ่าน Facebook เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "เข้าสู่ระบบด้วย Facebook", style: UIAlertActionStyle.default, handler: { (alert) in
                
                self.tabBarController?.performSegue(withIdentifier: "logout", sender: self)
                
            }))
            confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.destructive, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Change Activity's Language", message: "The application content need to be reloaded when you change the language and favorited activity will be lost. Are you sure to continue?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: { (alert) in
            
            if var currentLanguage = EntityHistory.getLanguage(inManageobjectcontext: self.managedObjectContext!) {
                
                self.managedObjectContext?.performAndWait {
                    
                    let fetchActivityData = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
                    let requestDeleteActivityData = NSBatchDeleteRequest(fetchRequest: fetchActivityData)
                    
                    let fetchEntityHistory = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityHistory")
                    let requestDeleteEntitiyHistory = NSBatchDeleteRequest(fetchRequest: fetchEntityHistory)
                    
                    let fetchFacilityData = NSFetchRequest<NSFetchRequestResult>(entityName: "FacilityData")
                    let requestDeleteFacilityData = NSBatchDeleteRequest(fetchRequest: fetchFacilityData)
                    
                    let fetchFavoritedData = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedActivity")
                    let requestDeleteFavoritedActivity = NSBatchDeleteRequest(fetchRequest: fetchFavoritedData)
                    
                    let fetchHighlighActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "HighlightActivity")
                    let requestDeleteHighlightActivity = NSBatchDeleteRequest(fetchRequest: fetchHighlighActivity)
                    
                    let fetchImageData = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageData")
                    let requestDeleteImageData = NSBatchDeleteRequest(fetchRequest: fetchImageData)
                    
                    let fetchNearbyActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "NearbyActivity")
                    let requestDeleteNearbyActivity = NSBatchDeleteRequest(fetchRequest: fetchNearbyActivity)
                    
                    let fetchPlaceData = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
                    let requestDeletePlaceData = NSBatchDeleteRequest(fetchRequest: fetchPlaceData)
                    
                    let fetchRecommendActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
                    let requestDeleteRecommendActivity = NSBatchDeleteRequest(fetchRequest: fetchRecommendActivity)
                    
                    let fetchReservedData = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
                    let requestDeleteReservedActivity = NSBatchDeleteRequest(fetchRequest: fetchReservedData)
                    
                    let fetchRoomData = NSFetchRequest<NSFetchRequestResult>(entityName: "RoomData")
                    let requestDeleteRoomData = NSBatchDeleteRequest(fetchRequest: fetchRoomData)
                    
                    let fetchRoundData = NSFetchRequest<NSFetchRequestResult>(entityName: "RoundData")
                    let requestDeleteRoundData = NSBatchDeleteRequest(fetchRequest: fetchRoundData)
                    
                    let fetchStageActivity = NSFetchRequest<NSFetchRequestResult>(entityName: "StageActivity")
                    let requestDeleteStageActivity = NSBatchDeleteRequest(fetchRequest: fetchStageActivity)
                    
                    let fetchTagData = NSFetchRequest<NSFetchRequestResult>(entityName: "TagData")
                    let requestDeleteTagData = NSBatchDeleteRequest(fetchRequest: fetchTagData)
                    
                    let fetchVideoData = NSFetchRequest<NSFetchRequestResult>(entityName: "VideoData")
                    let requestDeleteVideoData = NSBatchDeleteRequest(fetchRequest: fetchVideoData)
                    
                    let fetchZoneData = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
                    let requestDeleteZoneData = NSBatchDeleteRequest(fetchRequest: fetchZoneData)
                    
                    
                    do {
                        
                        try self.managedObjectContext?.execute(requestDeleteActivityData)
                        try self.managedObjectContext?.execute(requestDeleteEntitiyHistory)
                        try self.managedObjectContext?.execute(requestDeleteFacilityData)
                        try self.managedObjectContext?.execute(requestDeleteFavoritedActivity)
                        try self.managedObjectContext?.execute(requestDeleteHighlightActivity)
                        try self.managedObjectContext?.execute(requestDeleteImageData)
                        try self.managedObjectContext?.execute(requestDeleteNearbyActivity)
                        try self.managedObjectContext?.execute(requestDeletePlaceData)
                        try self.managedObjectContext?.execute(requestDeleteRecommendActivity)
                        try self.managedObjectContext?.execute(requestDeleteReservedActivity)
                        try self.managedObjectContext?.execute(requestDeleteRoomData)
                        try self.managedObjectContext?.execute(requestDeleteRoundData)
                        try self.managedObjectContext?.execute(requestDeleteStageActivity)
                        try self.managedObjectContext?.execute(requestDeleteTagData)
                        try self.managedObjectContext?.execute(requestDeleteVideoData)
                        try self.managedObjectContext?.execute(requestDeleteZoneData)
                        
                    } catch let error {
                        
                        print(error)
                        
                    }
                    
                    
                }
                
                if currentLanguage == "th" {
                    
                    Answers.logCustomEvent(withName: "Change Language", customAttributes: ["type": "TH"])
                    currentLanguage = (EntityHistory.addHistory(forEntityName: "LANGUAGE-EN", inManageobjectcontext: self.managedObjectContext!)?.name)!
                    
                } else {
                    
                    Answers.logCustomEvent(withName: "Change Language", customAttributes: ["type": "EN"])
                    currentLanguage = (EntityHistory.addHistory(forEntityName: "LANGUAGE-TH", inManageobjectcontext: self.managedObjectContext!)?.name)!
                    
                }
                
                let changeAlert = UIAlertController(title: "Current Language", message: "Your current activity's content language is \(currentLanguage)", preferredStyle: .alert)
                changeAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    
                    self.managedObjectContext?.performAndWait {
                        
                        APIController.downloadHightlightActivities(inManageobjectcontext: self.managedObjectContext!) { (success) in
                            
                            if success {
                                
                                APIController.downloadStageActivities(inManageobjectcontext: self.managedObjectContext!, completion: nil)
                                
                            }
                            
                        }
                        
                        APIController.downloadZone(inManageobjectcontext: self.managedObjectContext!)
                        APIController.downloadFacility(inManageobjectcontext: self.managedObjectContext!)
                        
                    }
                    
                    self.tabBarController?.performSegue(withIdentifier: "logout", sender: self.tabBarController)
                    
                }))
                
                self.present(changeAlert, animated: true, completion: nil)
                
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func equest(_ sender: UIButton) {
        
//        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
//        button2Alert.show()
        
    }
    
    var userType = "Academic"
    var iname: String?
    var firstName: String?
    var lastName: String?
    var iemail: String?
    var fbId: String!
    var fbToken: String!
    var fbImageProfileUrl: String?
    var fbImage: UIImage?
    var age: String!
    var Egender: String!
    var school: String!

    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext

    
    @IBOutlet weak var uni: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var agegen: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Answers.logContentView(withName: "Fourth",
                               contentType: nil,
                               contentId: nil,
                               customAttributes: nil)
        
        editproButton.titleLabel?.adjustsFontSizeToFitWidth = true
        managedObjectContext?.performAndWait {
            if let fetchUser = UserData.fetchUser(inManageobjectcontext: self.managedObjectContext!){
                
                var gen = "ไม่มีข้อมูล"
                switch fetchUser.gender ?? ""{
                    case "Male":
                        gen = "ชาย"
                    case "Female":
                        gen = "หญิง"
                    case "Other":
                        gen = "อื่นๆ"
                    default:
                        gen = "ไม่มีข้อมูล"
                }
                
                self.profileImg.imageFromServerURL(urlString: fetchUser.profile ?? "")
                self.name.text = (fetchUser.name ?? "")
                self.email.text = (fetchUser.email ?? "")
                self.agegen.text = "อายุ " + String(fetchUser.age) + " เพศ " + (gen)
                self.year.text = (fetchUser.level ?? "") + " " + (fetchUser.year ?? "")
                self.uni.text = (fetchUser.school ?? "")
                
                self.userType = (fetchUser.type ?? "")
                self.iname = (fetchUser.name ?? "")
                self.age = String(fetchUser.age)
                self.Egender = (fetchUser.gender ?? "")
                self.school = (fetchUser.school ?? "")
                
                let fullNameArr = (fetchUser.name ?? "").components(separatedBy: " ")
                
                if fullNameArr.count > 1 {
                    
                    self.lastName = fullNameArr[1]
                    
                }
                
                self.firstName = fullNameArr[0]
                
                
                self.iemail = (fetchUser.email ?? "")
//                self.fbId = fetchUser.
//                destination.fbToken = self.fbToken
//                destination.fbImageProfileUrl = self.fbImageProfileUrl
                self.fbImage = self.profileImg.image!
                
                
            } else {
                
                self.name.text = ""
                self.email.text = "ไม่พบข้อมูลผู้ใช้"
                self.agegen.text = "เพื่อเข้าถึงฟังก์ชั่นได้มากขึ้น"
                self.agegen.sizeToFit()
                self.year.text = "โปรดเข้าสู่ระบบผ่าน Facebook"
                self.uni.text = ""
                
                self.userType = ""
                self.iname = ""
                
                
                self.firstName = ""
                self.lastName = ""
                self.age = ""
                self.Egender = ""
                self.school = ""
                self.iemail = ""
                //                self.fbId = fetchUser.
                //                destination.fbToken = self.fbToken
                //                destination.fbImageProfileUrl = self.fbImageProfileUrl
                

            }
        }
        
//        profileImg.imageFromServerURL(urlString: <#T##String#>)
//        proView.layer.cornerRadius = 7.5
//        proView.layer.masksToBounds = true
        proView.cardStyle(background: proView)
        
        aboutAppView.cardStyle(background: aboutAppView)
//        editproButton.layer.cornerRadius = 3
//        editproButton.layer.masksToBounds = true
        editproButton.cardStyle(background: editproButton)
        
//        aboutView.layer.cornerRadius = 3
//        aboutView.layer.masksToBounds = true
        aboutView.cardStyle(background: aboutView)
        
//        faqView.layer.cornerRadius = 3
//        faqView.layer.masksToBounds = true
        faqView.cardStyle(background: faqView)
        
//        editfacView.layer.cornerRadius = 3
//        editfacView.layer.masksToBounds = true
        editfacView.cardStyle(background: editfacView)
        
//        edittagView.layer.cornerRadius = 3
//        edittagView.layer.masksToBounds = true
        edittagView.cardStyle(background: edittagView)
        
//        eventView.layer.cornerRadius = 3
//        eventView.layer.masksToBounds = true
        eventView.cardStyle(background: eventView)
        
//        reserveView.layer.cornerRadius = 3
//        reserveView.layer.masksToBounds = true
        reserveView.cardStyle(background: reserveView)
        
//        reserveView.layer.cornerRadius = 3
//        reserveView.layer.masksToBounds = true
        

//        logoutView.layer.cornerRadius = 5
//        logoutView.layer.masksToBounds = true
        logoutView.cardStyle(background: logoutView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        profileImg.layer.borderColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1).cgColor
        profileImg.layer.borderWidth = 3
        profileImg.layer.cornerRadius = profileImg.bounds.height / 2
        profileImg.layer.masksToBounds = true
        
    }
    
//    override func viewDidLayoutSubviews() {
//       
//        super.viewDidLayoutSubviews()
//        profileImg.layer.borderColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1).cgColor
//        profileImg.layer.borderWidth = 3
//        profileImg.layer.cornerRadius = profileImg.bounds.height / 2
//        profileImg.layer.masksToBounds = true
//        
//    }

    @IBAction func logoutAction(_ sender: Any) {
        let confirm = UIAlertController(title: "ออกจากระบบ", message: "คุณต้องการออกจากระบบใช่หรือไม่", preferredStyle: UIAlertControllerStyle.alert)
        
        confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
        
        confirm.addAction(UIAlertAction(title: "ออกจากระบบ", style: UIAlertActionStyle.destructive, handler: { (action) in
            
            let managedObjectContext: NSManagedObjectContext? =
                (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
            
            let fetchUserData = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            let requestDeleteUserData = NSBatchDeleteRequest(fetchRequest: fetchUserData)
            
            let fetchFavoritedData = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedActivity")
            let requestDeleteFavoritedActivity = NSBatchDeleteRequest(fetchRequest: fetchFavoritedData)
            
            let fetchReservedData = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
            let requestDeleteReservedActivity = NSBatchDeleteRequest(fetchRequest: fetchReservedData)
            
            do {
                
                try managedObjectContext?.execute(requestDeleteUserData)
                try managedObjectContext?.execute(requestDeleteFavoritedActivity)
                try managedObjectContext?.execute(requestDeleteReservedActivity)

                
                let loginManager = FBSDKLoginManager()
                loginManager.logOut()
                
                self.tabBarController?.performSegue(withIdentifier: "logout", sender: self.tabBarController)
                
            } catch let error {
                
                print(error)
                
            }
            
        }))
        
        self.present(confirm, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("\(segue.identifier)")
        if segue.identifier == "showEventReserve" {
            
            if let dest = segue.destination as? EventsTableViewController {
                
                dest.managedObjectContext = managedObjectContext
                dest.facity = "Reservation"
            }
        }
        if segue.identifier == "showEventFavorite" {
            
            if let dest = segue.destination as? EventsTableViewController {
                
                dest.managedObjectContext = managedObjectContext
                dest.facity = "Favorite"
                
            }
            
        }
        
    }
    
}
