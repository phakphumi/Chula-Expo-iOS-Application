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
        
        if UserController.loginStatus! {
            
            tabBarController?.performSegue(withIdentifier: "toQRCodeVC", sender: tabBarController)
            
        } else {
            
            let confirm = UIAlertController(title: "Coming soon", message: "This function will release soon.", preferredStyle: UIAlertControllerStyle.alert)
            
            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(confirm, animated: true, completion: nil)
        }
        
    }
    @IBAction func epro(_ sender: Any) {
        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
        button2Alert.show()
    }
    @IBAction func eTag(_ sender: Any) {
        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
        button2Alert.show()
    }
    
    @IBAction func eac(_ sender: Any) {
        let button2Alert: UIAlertView = UIAlertView(title: "", message: "Coming soon", delegate: self, cancelButtonTitle: "OK")
        button2Alert.show()
    }
    
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext

    
    @IBOutlet weak var uni: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var agegen: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = "ไม่พบข้อมูลผู้ใช้"
        
        managedObjectContext?.performAndWait {
            if let fetchUser = UserData.fetchUser(inManageobjectcontext: self.managedObjectContext!){
                self.name.text = fetchUser.name
                self.email.text = fetchUser.email
                self.agegen.text = "อายุ " + String(fetchUser.age) + " เพศ " + fetchUser.gender!
                self.year.text = (fetchUser.level ?? "") + " ปี" + (fetchUser.year ?? "")
                self.uni.text = fetchUser.school
            }
            
        }
        
        profileImg.layer.borderColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1).cgColor
        profileImg.layer.borderWidth = 3
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.masksToBounds = true
        proView.layer.cornerRadius = 7.5
        proView.layer.masksToBounds = true
        editproButton.layer.cornerRadius = 3
        editproButton.layer.masksToBounds = true
        aboutView.layer.cornerRadius = 3
        aboutView.layer.masksToBounds = true
        faqView.layer.cornerRadius = 3
        faqView.layer.masksToBounds = true
        editfacView.layer.cornerRadius = 3
        editfacView.layer.masksToBounds = true
        edittagView.layer.cornerRadius = 3
        edittagView.layer.masksToBounds = true
        eventView.layer.cornerRadius = 3
        eventView.layer.masksToBounds = true
        reserveView.layer.cornerRadius = 3
        reserveView.layer.masksToBounds = true
        reserveView.layer.cornerRadius = 3
        reserveView.layer.masksToBounds = true

        logoutView.layer.cornerRadius = 5
        logoutView.layer.masksToBounds = true

        
        // Do any additional setup after loading the view.
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
        if segue.identifier == "showFavorite" {
            
            if let dest = segue.destination as? EventsTableViewController {
                
                dest.managedObjectContext = managedObjectContext
                dest.facity = "Favorite"
            }
        }
        
        else if segue.identifier == "showReserve"{
            
            if let dest = segue.destination as? EventsTableViewController {
                
                print("dest")
                dest.managedObjectContext = managedObjectContext
                dest.facity = "Reservation"
            }
        }
    }
    
}
