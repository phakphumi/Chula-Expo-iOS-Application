//
//  ReservedAndFavoriteTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/21/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        
        while parentResponder != nil {
            
            parentResponder = parentResponder!.next
            
            if let viewController = parentResponder as? UIViewController {
                
                return viewController
                
            }
            
        }
        
        return nil
        
    }
    
}

class ReservedAndFavoriteTableViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var canReserve = false
    var canGroupReserve = false
    var isReserve = false
    var isFavorite = false
    
    var amountOfGroupReserveField: UITextField!
    var amountOfGroupReservePicker = UIPickerView()
    
    @IBOutlet var tapView: UIView!
    @IBOutlet var reservedIcon: UIImageView!
    @IBOutlet var reservedTitle: UILabel!
    @IBOutlet var cancelReservedIcon: UIImageView!
    @IBOutlet var cancelReservedTitle: UILabel!
    
    @IBOutlet var favoriteIcon: UIImageView!
    @IBOutlet var favoriteTitle: UILabel!
    @IBOutlet var cancelFavoriteIcon: UIImageView!
    @IBOutlet var cancelFavoriteTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        stylingTapview()
        
        initializeReservedAndFavoriteButton()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReservedAndFavoriteTableViewCell.wasTap))
        tapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func stylingTapview() {
        
        self.tapView.layer.cornerRadius = 2
        self.tapView.layer.borderWidth = 2
        self.tapView.layer.borderColor = UIColor.black.cgColor
        self.tapView.layer.masksToBounds = true
        
    }
    
    func initializeReservedAndFavoriteButton() {
        
        if canReserve {
            
            if isReserve {
                
                reservedIcon.alpha = 0
                reservedTitle.alpha = 0
                
                cancelReservedIcon.alpha = 1
                cancelReservedTitle.alpha = 1
                
                favoriteIcon.alpha = 0
                favoriteTitle.alpha = 0
                
                cancelFavoriteIcon.alpha = 0
                cancelFavoriteTitle.alpha = 0
                
            } else {
                
                reservedIcon.alpha = 1
                reservedTitle.alpha = 1
                
                cancelReservedIcon.alpha = 0
                cancelReservedTitle.alpha = 0
                
                favoriteIcon.alpha = 0
                favoriteTitle.alpha = 0
                
                cancelFavoriteIcon.alpha = 0
                cancelFavoriteTitle.alpha = 0
                
            }
            
        } else {
            
            if isFavorite {
                
                reservedIcon.alpha = 0
                reservedTitle.alpha = 0
                
                cancelReservedIcon.alpha = 0
                cancelReservedTitle.alpha = 0
                
                favoriteIcon.alpha = 0
                favoriteTitle.alpha = 0
                
                cancelFavoriteIcon.alpha = 1
                cancelFavoriteTitle.alpha = 1
                
            } else {
                
                reservedIcon.alpha = 0
                reservedTitle.alpha = 0
                
                cancelReservedIcon.alpha = 0
                cancelReservedTitle.alpha = 0
                
                favoriteIcon.alpha = 1
                favoriteTitle.alpha = 1
                
                cancelFavoriteIcon.alpha = 0
                cancelFavoriteTitle.alpha = 0
                
            }
            
        }
        
    }
    
    func wasTap() {
        
        if canGroupReserve {
        
            if isReserve {
                
                let confirm = UIAlertController(title: "ยกเลิกการจอง", message: "คุณต้องการยกเลิกการจองหรือไม่? (สามารถยกเลิกได้ก่อนเริ่มงาน 1 ชั่วโมง)", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
                
                confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                    
                    self.isReserve = false
                    
                    self.cancelReservedIcon.alpha = 0
                    self.cancelReservedTitle.alpha = 0
                    
                    self.reservedIcon.alpha = 1
                    self.reservedTitle.alpha = 1
                    
                    
                }))
                
                if let parentViewController = parentViewController as? UITableViewController {
                    
                    parentViewController.present(confirm, animated: true, completion: nil)
                    
                }
                
            } else {
                
                let chooseReserveType = UIAlertController(title: "เลือกประเภทการจอง", message: "กรุณาเลือกว่าต้องการจองแบบเดี่ยวหรือแบบกลุ่ม", preferredStyle: UIAlertControllerStyle.alert)
                
                chooseReserveType.addAction(UIAlertAction(title: "แบบกลุ่ม", style: UIAlertActionStyle.default, handler: { (action) in
                    
                    let confirm = UIAlertController(title: "ยืนยันการจองแบบกลุ่ม", message: "คุณต้องการยืนยันการจองหรือไม่ หากคุณยืนยันแล้วไม่เข้าร่วมงานตามเวลาที่กำหนดจะไม่สามารถจองกิจกรรมใด ๆ ได้อีก และกิจกรรมที่จองจะถูกยกเลิกทั้งหมด", preferredStyle: UIAlertControllerStyle.alert)
                    
                    confirm.addTextField(configurationHandler: { (textField) in
                        
                        textField.placeholder = "กรุณากรอกจำนวนคนที่ต้องการจองระหว่าง 1 - 50 คน"
                        
                        let toolbar = UIToolbar()
                        toolbar.barStyle = UIBarStyle.default
                        toolbar.isTranslucent = true
                        toolbar.sizeToFit()
                        
                        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegisterViewController.pickerDoneButton))
                        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
                        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RegisterViewController.pickerCancelButton))
                        
                        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
                        toolbar.isUserInteractionEnabled = true
                        
                        self.amountOfGroupReservePicker.delegate = self
                        self.amountOfGroupReservePicker.dataSource = self
                        
                        textField.inputAccessoryView = toolbar
                        textField.inputView = self.amountOfGroupReservePicker
                        
                    })
                    
                    self.amountOfGroupReserveField = confirm.textFields?.first
                    self.amountOfGroupReserveField.delegate = self
                    
                    confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
                    
                    confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                        
                        self.isReserve = true
                        
                        self.reservedIcon.alpha = 0
                        self.reservedTitle.alpha = 0
                        
                        self.cancelReservedIcon.alpha = 1
                        self.cancelReservedTitle.alpha = 1
                        
                        
                    }))
                    
                    if let parentViewController = self.parentViewController as? UITableViewController {
                        
                        parentViewController.present(confirm, animated: true, completion: nil)
                        
                    }
                    
                }))
                
                chooseReserveType.addAction(UIAlertAction(title: "แบบเดี่ยว", style: UIAlertActionStyle.default, handler: { (action) in
                    
                    let confirm = UIAlertController(title: "ยืนยันการจอง", message: "คุณต้องการยืนยันการจองหรือไม่ หากคุณยืนยันแล้วไม่เข้าร่วมงานตามเวลาที่กำหนดจะไม่สามารถจองกิจกรรมใดๆภายในวันเดียวกันได้อีก และกิจกรรมที่จองภายในวันเดียวกันจะถูกยกเลิกทั้งหมด", preferredStyle: UIAlertControllerStyle.alert)
                    
                    confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
                    
                    confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                        
                        self.isReserve = true
                        
                        self.reservedIcon.alpha = 0
                        self.reservedTitle.alpha = 0
                        
                        self.cancelReservedIcon.alpha = 1
                        self.cancelReservedTitle.alpha = 1
                        
                        
                    }))
                    
                    if let parentViewController = self.parentViewController as? UITableViewController {
                        
                        parentViewController.present(confirm, animated: true, completion: nil)
                        
                    }
                    
                }))
                
                if let parentViewController = parentViewController as? UITableViewController {
                    
                    parentViewController.present(chooseReserveType, animated: true, completion: nil)
                    
                }
                
            }

        } else if canReserve {
            
            if isReserve {
                
                let confirm = UIAlertController(title: "ยกเลิกการจอง", message: "คุณต้องการยกเลิกการจองหรือไม่? (สามารถยกเลิกได้ก่อนเริ่มงาน 15 นาที)", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
                
                confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                    
                    self.isReserve = false
                    
                    self.cancelReservedIcon.alpha = 0
                    self.cancelReservedTitle.alpha = 0
                    
                    self.reservedIcon.alpha = 1
                    self.reservedTitle.alpha = 1

                    
                }))
                
                if let parentViewController = parentViewController as? UITableViewController {
                    
                    parentViewController.present(confirm, animated: true, completion: nil)
                    
                }
                
            } else {
                
                let confirm = UIAlertController(title: "ยืนยันการจอง", message: "คุณต้องการยืนยันการจองหรือไม่ หากคุณยืนยันแล้วไม่เข้าร่วมงานตามเวลาที่กำหนดจะไม่สามารถจองกิจกรรมใดๆภายในวันเดียวกันได้อีก และกิจกรรมที่จองภายในวันเดียวกันจะถูกยกเลิกทั้งหมด", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
                
                confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                    
                    self.isReserve = true
                    
                    self.reservedIcon.alpha = 0
                    self.reservedTitle.alpha = 0
                    
                    self.cancelReservedIcon.alpha = 1
                    self.cancelReservedTitle.alpha = 1
                    
                    
                }))
                
                if let parentViewController = parentViewController as? UITableViewController {
                    
                    parentViewController.present(confirm, animated: true, completion: nil)
                    
                }
                
            }
        
        } else {
            
            if isFavorite {
                
                let confirm = UIAlertController(title: "ยกเลิกการรายการโปรด", message: "คุณต้องการยกเลิกรายการโปรดใช่หรือไม่", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
                
                confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                    
                    self.isFavorite = false
                    
                    self.cancelFavoriteIcon.alpha = 0
                    self.cancelFavoriteTitle.alpha = 0
                    
                    self.favoriteIcon.alpha = 1
                    self.favoriteTitle.alpha = 1
                    
                    
                }))
                
                if let parentViewController = parentViewController as? UITableViewController {
                    
                    parentViewController.present(confirm, animated: true, completion: nil)
                    
                }
                
            } else {
                
                let confirm = UIAlertController(title: "ยืนยันรายการโปรด", message: "คุณต้องการเพิ่มเข้ารายการโปรดใช่หรือไม่", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "ยกเลิก", style: UIAlertActionStyle.default, handler: nil))
                
                confirm.addAction(UIAlertAction(title: "ยืนยัน", style: UIAlertActionStyle.destructive, handler: { (action) in
                    
                    self.isFavorite = true
                    
                    self.favoriteIcon.alpha = 0
                    self.favoriteTitle.alpha = 0
                    
                    self.cancelFavoriteIcon.alpha = 1
                    self.cancelFavoriteTitle.alpha = 1
                    
                    
                }))
                
                if let parentViewController = parentViewController as? UITableViewController {
                    
                    parentViewController.present(confirm, animated: true, completion: nil)
                    
                }
                
            }
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return true}
        
        return text.characters.count <= 50
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(row + 1)"
        
    }
    
    func pickerCancelButton() {
        
        amountOfGroupReserveField.resignFirstResponder()
        
    }
    
    func pickerDoneButton() {
            
        amountOfGroupReserveField.text = "\(amountOfGroupReservePicker.selectedRow(inComponent: 0) + 1)"
        
        amountOfGroupReserveField.resignFirstResponder()
        
    }

}
