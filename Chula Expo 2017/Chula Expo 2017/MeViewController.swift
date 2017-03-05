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

class MeViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var profileImg: UIImageView!

    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var aboutView: UIView!
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
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ฟังก์ชัน QR Code เปิดให้ใช้งานได้เฉพาะผู้ใช้ที่ลงทะเบียนผ่าน Facebook เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func aboutUs(_ sender: UIButton) {
        
        let aboutView = storyboard?.instantiateViewController(withIdentifier: "aboutUs") as? AboutViewController
        
        tabBarController?.present(aboutView!, animated: true, completion: nil)
        
    }

    @IBAction func favoriteSoon(_ sender: UIButton) {
        
        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
        button2Alert.show()
        
    }
    @IBAction func reserveSoon(_ sender: UIButton) {
        
        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
        button2Alert.show()
        
    }
    @IBAction func editInformation(_ sender: UIButton) {
//        
//        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
//        button2Alert.show()
        if UserData.isThereUser(inManageobjectcontext: self.managedObjectContext!) {
            
            tabBarController?.performSegue(withIdentifier: "editInfo", sender: self)
            
        } else {
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ฟังก์ชันแก้ไขข้อมูลเปิดให้ใช้งานได้เฉพาะ Facebook User เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }

    @IBAction func editTag(_ sender: UIButton) {
        
        if UserData.isThereUser(inManageobjectcontext: self.managedObjectContext!) {
            
            tabBarController?.performSegue(withIdentifier: "editTag", sender: self)
            
        } else {
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ฟังก์ชันแก้ไขข้อมูลเปิดให้ใช้งานได้เฉพาะ Facebook User เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func editFac(_ sender: UIButton) {
        
        if UserData.isThereUser(inManageobjectcontext: self.managedObjectContext!) {
            
            tabBarController?.performSegue(withIdentifier: "editTag", sender: self)
            
        } else {
            
            let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ฟังก์ชันแก้ไขข้อมูลเปิดให้ใช้งานได้เฉพาะ Facebook User เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    @IBAction func equest(_ sender: UIButton) {
        
        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
        button2Alert.show()
        
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
        
        editproButton.titleLabel?.adjustsFontSizeToFitWidth = true
        managedObjectContext?.performAndWait {
            if let fetchUser = UserData.fetchUser(inManageobjectcontext: self.managedObjectContext!){
                
                self.profileImg.imageFromServerURL(urlString: fetchUser.profile ?? "")
                self.name.text = (fetchUser.name ?? "")
                self.email.text = (fetchUser.email ?? "")
                self.agegen.text = "อายุ " + String(fetchUser.age) + " เพศ " + (fetchUser.gender ?? "")
                self.year.text = (fetchUser.level ?? "") + " " + (fetchUser.year ?? "")
                self.uni.text = (fetchUser.school ?? "")
                
                self.userType = (fetchUser.type ?? "")
                self.iname = (fetchUser.name ?? "")
                self.age = String(fetchUser.age)
                self.Egender = (fetchUser.gender ?? "")
                self.school = (fetchUser.school ?? "")
                let fullNameArr = (fetchUser.name ?? "").components(separatedBy: " ")
                
                self.firstName = fullNameArr[0]
                self.lastName = fullNameArr[1]
                
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
    
    override func viewDidLayoutSubviews() {
       
        super.viewDidLayoutSubviews()
        profileImg.layer.borderColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1).cgColor
        profileImg.layer.borderWidth = 3
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutAction(_ sender: Any) {
        let confirm = UIAlertController(title: "ออกจากระบบ", message: "คุณต้องการออกจากระบบใช่หรือไม่", preferredStyle: UIAlertControllerStyle.alert)
        
        confirm.addAction(UIAlertAction(title: "ไม่ใช่", style: UIAlertActionStyle.default, handler: nil))
        
        confirm.addAction(UIAlertAction(title: "ใช่", style: UIAlertActionStyle.destructive, handler: { (action) in
            
            let managedObjectContext: NSManagedObjectContext? =
                (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
            
            let fetchActivityData = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
            let requestDeleteActivityData = NSBatchDeleteRequest(fetchRequest: fetchActivityData)
            
            let fetchZoneData = NSFetchRequest<NSFetchRequestResult>(entityName: "ZoneData")
            let requestDeleteZoneData = NSBatchDeleteRequest(fetchRequest: fetchZoneData)
            
            let fetchImageData = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageData")
            let requestDeleteImageData = NSBatchDeleteRequest(fetchRequest: fetchImageData)
            
            let fetchTagData = NSFetchRequest<NSFetchRequestResult>(entityName: "TagData")
            let requestDeleteTagData = NSBatchDeleteRequest(fetchRequest: fetchTagData)
            
            let fetchUserData = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            let requestDeleteUserData = NSBatchDeleteRequest(fetchRequest: fetchUserData)
            
            let fetchVideoData = NSFetchRequest<NSFetchRequestResult>(entityName: "VideoData")
            let requestDeleteVideoData = NSBatchDeleteRequest(fetchRequest: fetchVideoData)
            
            let fetchPlaceData = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceData")
            let requestDeletePlaceData = NSBatchDeleteRequest(fetchRequest: fetchPlaceData)
            
            let fetchRoomData = NSFetchRequest<NSFetchRequestResult>(entityName: "RoomData")
            let requestDeleteRoomData = NSBatchDeleteRequest(fetchRequest: fetchRoomData)
            
            let fetchRoundData = NSFetchRequest<NSFetchRequestResult>(entityName: "RoundData")
            let requestDeleteRoundData = NSBatchDeleteRequest(fetchRequest: fetchRoundData)
            
            let fetchFacilityData = NSFetchRequest<NSFetchRequestResult>(entityName: "FacilityData")
            let requestDeleteFacilityData = NSBatchDeleteRequest(fetchRequest: fetchFacilityData)
            
            let fetchFavoritedData = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedActivity")
            let requestDeleteFavoritedActivity = NSBatchDeleteRequest(fetchRequest: fetchFavoritedData)
            
            let fetchReservedData = NSFetchRequest<NSFetchRequestResult>(entityName: "ReservedActivity")
            let requestDeleteReservedActivity = NSBatchDeleteRequest(fetchRequest: fetchReservedData)
            
            do {
                
                try managedObjectContext?.execute(requestDeleteActivityData)
                try managedObjectContext?.execute(requestDeleteZoneData)
                try managedObjectContext?.execute(requestDeleteImageData)
                try managedObjectContext?.execute(requestDeleteTagData)
                try managedObjectContext?.execute(requestDeleteUserData)
                try managedObjectContext?.execute(requestDeleteVideoData)
                try managedObjectContext?.execute(requestDeletePlaceData)
                try managedObjectContext?.execute(requestDeleteRoomData)
                try managedObjectContext?.execute(requestDeleteRoundData)
                try managedObjectContext?.execute(requestDeleteFacilityData)
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
        else if segue.identifier == "toRegister1" {
                
                let destination = segue.destination as! RegisterViewController
                
                destination.userType = self.userType
                destination.name = self.iname
                destination.firstName = self.firstName
                destination.lastName = self.lastName
                destination.email = self.iemail
                destination.fbId = self.fbId
                destination.fbToken = self.fbToken
                destination.fbImageProfileUrl = self.fbImageProfileUrl
                destination.fbImage = self.fbImage
                destination.managedObjectContext = self.managedObjectContext
                destination.age = self.age
                destination.Egender = self.Egender
                destination.school = self.school
                destination.isEdited = true
                
        }
            
        
        
    }
    
}
