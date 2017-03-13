//
//  FavoriteViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/3/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import Answers

protocol FavoriteViewControllerDelegate {
    
    func updateData(wasUpdated: Bool)
    
}

class FavoriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var delegate: FavoriteViewControllerDelegate?
    
    var activityId: String!
    var topic: String!
    var reservable = false
    var wasFavorited = false
    var managedObjectContext: NSManagedObjectContext?
    
    var roundsId = [String]()
    var dates = [String]()
    var times = [String: [String]]()
    var dateTimeList = [String](){
        didSet{
            dateTimeList.remove(at: 0)
        }
    }
    var selectedRow = 0

    let dateTimePicker = UIPickerView()

    @IBOutlet var titleIcon: UIImageView!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var dateTimeField: UITextField!
    @IBOutlet var dateTimeFieldView: UIView!
    @IBOutlet var saveButton: UIButton!
    
    func notification(title: String, body: String, dateToNoti: Date) {
        
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceReferenceDate: dateToNoti.timeIntervalSinceReferenceDate - 900)
        notification.alertBody = body
        notification.alertTitle = title
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if reservable {
            
            if UserData.isThereUser(inManageobjectcontext: managedObjectContext!) {
            
                if let userData = UserData.fetchUser(inManageobjectcontext: managedObjectContext!) {
                    
                    print("https://staff.chulaexpo.com/api/activities/\(activityId!)/rounds/\(roundsId[selectedRow])/reserve")
                    let header: HTTPHeaders = ["Authorization": "JWT \(userData.token!)"]
                    
                    Alamofire.request("https://staff.chulaexpo.com/api/activities/\(activityId!)/rounds/\(roundsId[selectedRow])/reserve", method: .post, headers: header).responseJSON { response in
                        
                        if response.result.isSuccess {
                            
                            let JSON = response.result.value as! NSDictionary
                            print(JSON)
                            
                            let success = JSON["success"] as! Bool
                            
                            if success {
                                
                                self.managedObjectContext?.performAndWait {
                                    
                                    ActivityData.fetchActivityData(activityId: self.activityId, inManageobjectcontext: self.managedObjectContext!, completion: { (activityData) in
                                        
                                        if let activityData = activityData {
                                            
                                            ReservedActivity.addData(activityId: self.activityId, roundId: self.roundsId[self.selectedRow], activityData: activityData, inManageobjectcontext: self.managedObjectContext!, completion: nil)
                                            
                                            
                                        }
                                        
                                    })
                                    
                                }
                                
                                do{
                                    
                                    try self.managedObjectContext?.save()
                                    
                                    let confirm = UIAlertController(title: "ยืนยันสำเร็จ", message: "ดำเนินการเรียบร้อย", preferredStyle: UIAlertControllerStyle.alert)
                                    confirm.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                                        
                                        self.delegate?.updateData(wasUpdated: true)
                                        
                                        Answers.logCustomEvent(withName: "Reserved", customAttributes: ["Activity": self.activityId, "Action": "Reserved"])
                                        
                                        RoundData.fetchRoundData(roundId: self.roundsId[self.selectedRow], inManageobjectcontext: self.managedObjectContext!, completion: { (roundData) in
                                            
                                            self.notification(title: "กิจกรรมที่จองกำลังจะเริ่ม", body: roundData?.toActivity?.name ?? "", dateToNoti: roundData?.startTime ?? Date())
                                            
                                        })
                                        
                                        self.dismiss(animated: true, completion: nil)
                                        
                                    }))
                                    
                                    self.present(confirm, animated: true, completion: nil)
                                    
                                }
                                    
                                catch let error {
                                    
                                    print("FavoritedActivity save error with \(error)")
                                    
                                }
                                
                            } else {
                                
                                let errors = JSON["errors"] as! NSDictionary
                                
                                let code = errors["code"] as! String
                                
                                var message = String()
                                
                                switch code {
                                    
                                case "28":
                                    
                                    message = "คุณเคยจองกิจกรรมรอบนี้แล้ว"
                                    
                                case "30":
                                    
                                    message = "ตั๋วกิจกรรมบน Application สำหรับรอบนี้ถูกจองหมดแล้ว. (บางกิจกรรมอาจมีการเปิดรับเพิ่มที่หน้างาน)"
                                    
                                default:
                                    
                                    message = errors["message"] as! String
                                    
                                }
                                
                                let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: message, preferredStyle: UIAlertControllerStyle.alert)
                                
                                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                
                                self.present(confirm, animated: true, completion: nil)

                                
                            }
                            
                        } else {
                            
                            let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                            
                            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            
                            self.present(confirm, animated: true, completion: nil)
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                let confirm = UIAlertController(title: "ข้อผิดพลาด", message: "ฟังก์ชันการจองเปิดให้ใช้งานได้เฉพาะผู้ใช้ที่ลงทะเบียนผ่าน Facebook เท่านั้น!", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "เข้าสู่ระบบด้วย Facebook", style: UIAlertActionStyle.default, handler: { (alert) in
                    
                    self.tabBarController?.performSegue(withIdentifier: "logout", sender: self)
                    
                }))
                confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.destructive, handler: nil))
                
                
                self.present(confirm, animated: true, completion: nil)
                
            }
            
        } else {
            
            var confirm = UIAlertController()
            
            if wasFavorited {
                
                
                _ = FavoritedActivity.deleteFavoritedActivity(fromActivityID: self.activityId, inManageobjectcontext: managedObjectContext!)
                
                do{
                    
                    try managedObjectContext?.save()
                    
                    confirm = UIAlertController(title: "ยืนยันสำเร็จ", message: "ดำเนินการเรียบร้อย", preferredStyle: UIAlertControllerStyle.alert)
                    confirm.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                       
                        self.delegate?.updateData(wasUpdated: true)
                        
                        Answers.logCustomEvent(withName: "Favorited", customAttributes: ["Activity": self.activityId, "Action": "Favorited"])
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }))
                    
                    print("DeleteFavoritedActivity Saved")
                    
                }
                    
                catch let error {
                    
                    print("Delete FavoritedActivity save error with \(error)")
                    
                    confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "บันทึกข้อมูลล้มเหลว กรุณาลองใหม่อีกครั้ง", preferredStyle: UIAlertControllerStyle.alert)
                    confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil))
                    
                }
                
                self.present(confirm, animated: true, completion: nil)
                
            } else {
            
            
                _ = FavoritedActivity.addData(activityId: self.activityId, inManageobjectcontext: managedObjectContext!)
                
                
                do{
                    
                    try managedObjectContext?.save()
                    
                    confirm = UIAlertController(title: "ยืนยันสำเร็จ", message: "ดำเนินการเรียบร้อย", preferredStyle: UIAlertControllerStyle.alert)
                    confirm.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        
                        self.delegate?.updateData(wasUpdated: true)
                        
                        Answers.logCustomEvent(withName: "Favorited", customAttributes: ["Activity": self.activityId, "Action": "Cancel"])
                        
                        ActivityData.fetchActivityData(activityId: self.activityId, inManageobjectcontext: self.managedObjectContext!, completion: { (activityData) in
                            
                            self.notification(title: "กิจกรรมที่คุณสนใจกำลังจะเริ่ม", body: activityData?.name ?? "", dateToNoti: (activityData?.start)!)
                            
                        })
                        
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }))
                    
                    print("FavoritedActivity Saved")
                    
                }
                    
                catch let error {
                    
                    print("FavoritedActivity save error with \(error)")
                    
                    confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "บันทึกข้อมูลล้มเหลว กรุณาลองใหม่อีกครั้ง", preferredStyle: UIAlertControllerStyle.alert)
                    confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil))
                    
                }
                
                self.present(confirm, animated: true, completion: nil)
                
            }
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.view.frame
//        
//        self.view.insertSubview(blurEffectView, at: 0)
        
        Answers.logContentView(withName: "Activity Reserved",
                               contentType: nil,
                               contentId: activityId,
                               customAttributes: nil)
        
        wasFavorited = FavoritedActivity.isFavoritedActivity(fromActivityID: activityId, inManageobjectcontext: managedObjectContext!)
        
        if reservable {
            
            dateTimeFieldView.alpha = 1
            
            dateTimeField.text = dateTimeList[0]
        
            dateTimePicker.delegate = self
            dateTimePicker.dataSource = self
            
            addPickerToolbar()
        
        } else {
            
            saveButton.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height * 0.05)
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        dateTimeField.layer.borderWidth = 3
        dateTimeField.layer.borderColor = UIColor.white.cgColor
        dateTimeField.layer.cornerRadius = dateTimeField.frame.height / 2
        dateTimeField.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.layer.masksToBounds = true
        
        initialTitle()
        topicLabel.text = self.topic
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dateTimeList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dateTimeList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedRow = row
        dateTimeField.text = dateTimeList[row]
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dateTimeField.resignFirstResponder()
        
    }
    
    private func addPickerToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(FavoriteViewController.pickerDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        dateTimeField.inputAccessoryView = toolbar
        dateTimeField.inputView = dateTimePicker
        
    }
    
    func pickerDoneButton() {
        
        dateTimeField.resignFirstResponder()
        
    }
    
    private func initialTitle() {
        
        if reservable {
        
            titleIcon.image = #imageLiteral(resourceName: "ticketBlue")
            titleText.text = "จองกิจกรรมนี้"
        
        } else if wasFavorited {
            
            titleText.text = "ยกเลิกการสนใจ"
            titleText.textColor = UIColor.red
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
