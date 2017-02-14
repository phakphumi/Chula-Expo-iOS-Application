//
//  FavoriteViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/3/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var activityId: String!
    var topic: String!
    var reservable = false
    var managedObjectContext: NSManagedObjectContext?
    
    
    var dates = [String]()
    var times = [String: [String]]()
    var dateTimeList = [String]()

    let dateTimePicker = UIPickerView()

    @IBOutlet var titleIcon: UIImageView!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var dateTimeField: UITextField!
    @IBOutlet var dateTimeFieldView: UIView!
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if reservable {
            
            
        } else {
            
            var confirm = UIAlertController()
            
            
            
            if FavoritedActivity.addData(activityId: self.activityId, inManageobjectcontext: managedObjectContext!)! {
                
                confirm = UIAlertController(title: "ยืนยันสำเร็จ", message: "ดำเนินการเรียบร้อย", preferredStyle: UIAlertControllerStyle.alert)
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                
            } else {
                
                confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ท่านเคยบันทึกรายการนี้ไว้แล้ว", preferredStyle: UIAlertControllerStyle.alert)
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
            }
            
            
            do{
                
                try managedObjectContext?.save()
                print("FavoritedActivity Saved")
                
            }
                
            catch let error {
                
                print("FavoritedActivity save error with \(error)")
                
                confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "บันทึกข้อมูลล้มเหลวกรุณาลองใหม่อีกครั้ง", preferredStyle: UIAlertControllerStyle.alert)
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil))
                
            }
            
            self.present(confirm, animated: true, completion: nil)
            
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        
        self.view.insertSubview(blurEffectView, at: 0)
        
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
            titleText.text = "จอง EVENT นี้"
        
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
