//
//  RegisterViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/26/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController2: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let genderPicker = UIPickerView()
    let gender = ["ชาย", "หญิง", "อื่น ๆ"]
    
    var userType = "student"
    var isFrameMove = false // false when frame did not move, true when frame did move
    var name: String!
    var email: String!
    var imageProfile: UIImage!
    var activeField: UITextField!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var imageProfileView: UIImageView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var careerView: UIView!
    @IBOutlet var studentRadio: UIButton!
    @IBOutlet var adultRadio: UIButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var schoolField: UITextField!
    @IBOutlet var companyField: UITextField!
    @IBOutlet var yearField: UITextField!
    @IBOutlet var positionField: UITextField!
    
    @IBOutlet var schoolLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    
    @IBOutlet var doneButton: UIButton!
    
    var token: String!
    var fbImageProfileUrl: String!
    var nameLabelView: UILabel!
    var student: UIButton!
    var worker: UIButton!
    
    var studentCheckmark: UIImageView!
    var workerCheckmark: UIImageView!
    
    @IBAction func selectStudent(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        userType = "student"
        
        adultRadio.backgroundColor = nil
        adultRadio.setTitleColor(UIColor.white, for: .normal)
        
        studentRadio.backgroundColor = UIColor.white
        studentRadio.setTitleColor(UIColor.black, for: .normal)
        
        UIView.animate(withDuration: 0.25) {
            
            self.companyLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.companyField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.positionLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.positionField.transform = CGAffineTransform(translationX: 0, y: 0)
            
            
            self.schoolLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.schoolField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.yearLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.yearField.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }
        
    }
    
    @IBAction func selectAdult(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        userType = "adult"
        
        studentRadio.backgroundColor = nil
        studentRadio.setTitleColor(UIColor.white, for: .normal)
        
        adultRadio.backgroundColor = UIColor.white
        adultRadio.setTitleColor(UIColor.black, for: .normal)
        
        UIView.animate(withDuration: 0.25) {
            
            self.companyLabel.transform = CGAffineTransform(translationX: -1000, y: 0)
            self.companyField.transform = CGAffineTransform(translationX: -1000, y: 0)
            self.positionLabel.transform = CGAffineTransform(translationX: -1000, y: 0)
            self.positionField.transform = CGAffineTransform(translationX: -1000, y: 0)
            
            
            self.schoolLabel.transform = CGAffineTransform(translationX: -1000, y: 0)
            self.schoolField.transform = CGAffineTransform(translationX: -1000, y: 0)
            self.yearLabel.transform = CGAffineTransform(translationX: -1000, y: 0)
            self.yearField.transform = CGAffineTransform(translationX: -1000, y: 0)
            
        }
        
    }
    

    @IBAction func nextButton(_ sender: UIButton) {
        
        var message = ""
        
        validateStylingTextField(textField: emailField)
        validateStylingTextField(textField: ageField)
        validateStylingTextField(textField: genderField)
        validateStylingTextField(textField: schoolField)
        validateStylingTextField(textField: yearField)
        validateStylingTextField(textField: companyField)
        validateStylingTextField(textField: positionField)
        
        if userType == "student" {
        
            if nameField.text == "" || emailField.text == "" || ageField.text == "" || genderField.text == "" || schoolField.text == "" || yearField.text == "" {
            
                message = "กรุณากรอกข้อมูลให้ครบทุกช่อง"
            
            } else if Int(yearField.text!)! > 12 {
                
                message = "ชั้นปีต้องอยู่ระหว่าง 1 - 12"
                
                warningStylingTextField(textField: yearField)
                
            }
            
        } else {
            
            if nameField.text == "" || emailField.text == "" || ageField.text == "" || genderField.text == "" || companyField.text == "" || positionField.text == "" {
                
                message = "กรุณากรอกข้อมูลให้ครบทุกช่อง"
                
            }
            
        }
        
        
        
        if let age = Int(ageField.text!) {
         
            if age > 120 {
                
                message = "อายุต้องไม่เกิน 120 ปี"
                
                warningStylingTextField(textField: ageField)
                
            }
            
        }
        
        
        
        if message != "" {
            
            let error = UIAlertController(title: "ข้อมูลไม่ถูกต้อง", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(error, animated: true, completion: nil)
            
        } else {
            
            let managedObjectContext: NSManagedObjectContext? =
                (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
            
            if userType == "student" {
            
//                managedObjectContext?.performAndWait {
//                
////                    _ = UserData.addUser(
//                        id: UserController.userId!,
//                        token: self.token,
//                        userType: "student",
//                        name: self.nameField.text!,
//                        email: self.emailField.text!,
//                        age: Int(self.ageField.text!)!,
//                        gender: self.genderField.text!,
//                        school: self.schoolField.text!,
//                        company: "",
//                        year: Int(self.yearField.text!)!,
//                        position: "",
//                        pictureUrl: self.fbImageProfileUrl!,
//                        inManageobjectcontext: managedObjectContext!
//                    )
//                
//                }
                
            } else {
                
//                managedObjectContext?.performAndWait {
//                    
//                    _ = UserData.addUser(
//                        id: UserController.userId!,
//                        token: self.token,
//                        userType: "student",
//                        name: self.nameField.text!,
//                        email: self.emailField.text!,
//                        age: Int(self.ageField.text!)!,
//                        gender: self.genderField.text!,
//                        school: "",
//                        company: self.companyField.text!,
//                        year: 0,
//                        position: self.positionField.text!,
//                        pictureUrl: self.fbImageProfileUrl!,
//                        inManageobjectcontext: managedObjectContext!
//                    )
//                    
//                }
                
            }
            
            do {
                
                try managedObjectContext?.save()
                print("saved user")
                
            } catch let error {
              
                print("saveUserError with \(error)")
                
            }

            
            performSegue(withIdentifier: "toInterestedView", sender: self)
            
        }
        
    }
    
    private func printDatabaseStatistics() {
        
        let managedObjectContext: NSManagedObjectContext? =
            (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext

        managedObjectContext?.perform {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            
            request.returnsObjectsAsFaults = false
            
            if let result = try? managedObjectContext!.fetch(request).first as? UserData{
                
                print("Total datas in coredata \(result)")
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        setInitialValue()
        
        addChangeProfileImageGesture()
        
        createGradientLayer()
        
        emailField.tag = 1
        ageField.tag = 2
        genderField.tag = 3
        schoolField.tag = 4
        yearField.tag = 5
        companyField.tag = 7
        positionField.tag = 8
        
        stylingTextField(textField: emailField)
        stylingTextField(textField: ageField)
        stylingTextField(textField: genderField)
        stylingTextField(textField: schoolField)
        stylingTextField(textField: yearField)
        stylingTextField(textField: companyField)
        stylingTextField(textField: positionField)
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegisterViewController2.pickerDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RegisterViewController2.pickerCancelButton))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        genderField.inputAccessoryView = toolbar
        genderField.inputView = genderPicker
        
        ageField.inputAccessoryView = toolbar
        yearField.inputAccessoryView = toolbar
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController2.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController2.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        printDatabaseStatistics()
    }
    
    override func viewDidLayoutSubviews() {
        
        stylingProfileImage()
        
        stylingRadio()
        
        stylingDoneButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if activeField == nameField && activeField.text == "" {
            let error = UIAlertController(title: "ข้อมูลไม่ถูกต้อง", message: "กรุณากรอกชื่อ-นามสกุล", preferredStyle: UIAlertControllerStyle.alert)
        
            error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
            self.present(error, animated: true, completion: nil)
            
        } else {
        
            self.view.endEditing(true)
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameField {
            
            if textField.text == "" {
                
                let error = UIAlertController(title: "ข้อมูลไม่ถูกต้อง", message: "กรุณากรอกชื่อ-นามสกุล", preferredStyle: UIAlertControllerStyle.alert)
                
                error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(error, animated: true, completion: nil)
                
            } else {
                
                textField.resignFirstResponder()
                
            }
            
        } else {
        
            // Try to find next responder
                
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                    
                nextField.becomeFirstResponder()
                    
            } else {
                    
                // Not found, so remove keyboard.
                textField.resignFirstResponder()
                
            }
            
        }
        
        return false
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeField = textField
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return gender[row]
        
    }
    
    func pickerCancelButton() {
        
        activeField.resignFirstResponder()
        
    }
    
    func pickerDoneButton() {
        
        if activeField == genderField {
         
            genderField.text = gender[genderPicker.selectedRow(inComponent: 0)]
        
        }
        
        // Try to find next responder
        if userType == "adult" && activeField == genderField {
            
                companyField.becomeFirstResponder()
            
        } else if let nextField = self.view.viewWithTag(activeField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            // Not found, so remove keyboard.
            activeField.resignFirstResponder()
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageProfileView.image = image
            
        } else {
            
            print("error while access photo library")
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func keyboardWillShow(notification: NSNotification) {
        
        let heightToDecrease = self.view.bounds.height * 0.15
        
        if !isFrameMove && activeField != genderField{
            
            isFrameMove = true
        
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                self.hideImageView()
                 
                self.moveNameFieldToTopCenterView(movingFrame: keyboardSize.height - heightToDecrease)
                
                UIView.animate(withDuration: 0.5, animations: {
                        
                    self.view.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height - heightToDecrease))
                    
                })
            
            }
            
        } else if !isFrameMove && activeField == genderField {
            
            isFrameMove = true
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                self.hideImageView()
                
                self.moveNameFieldToTopCenterView(movingFrame: keyboardSize.height - heightToDecrease - (genderPicker.inputAccessoryView?.frame.height)!)
                
                UIView.animate(withDuration: 0.5, animations: {
                        
                    self.view.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height - heightToDecrease - (self.genderPicker.inputAccessoryView?.frame.height)!))
                    
                })
                
            }
            
        }
    
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if isFrameMove {
        
            isFrameMove = false
                
            self.showImageView()
            self.moveNameFieldToBeginning()

            UIView.animate(withDuration: 0.5, animations: {
                    
                self.view.transform = CGAffineTransform(translationX: 0, y: 0)
                    
            })
        
        }
        
    }
    
    func moveNameFieldToTopCenterView(movingFrame: CGFloat) {
        
        let nameFieldTopMargin = nameField.frame.origin.y
        
        let remainingNameFieldTopMargin = nameFieldTopMargin - movingFrame
        let remainingGradientHeight = topView.bounds.height - movingFrame - UIApplication.shared.statusBarFrame.height
        
        let movingNameField = remainingGradientHeight / 2 - remainingNameFieldTopMargin
        
        UIView.animate(withDuration: 0.5) {
            
            self.nameField.transform = CGAffineTransform(translationX: 0, y: movingNameField)
            
        }
        
        
    }
    
    func moveNameFieldToBeginning() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.nameField.transform = CGAffineTransform(translationX: 0, y: 0)
            
            
        }
        
    }
    
    func hideImageView() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.imageProfileView.transform = CGAffineTransform(translationX: 0, y: -300)
            
        }
        
    }
    
    func showImageView() {
        
        UIView.animate(withDuration: 0.5) {
            self.imageProfileView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
    }
    
    func stylingTextField(textField: UITextField) {
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 0.20).cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        border.zPosition = -1
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        
    }
    
    func validateStylingTextField(textField: UITextField) {
        
        let border = (textField.layer.sublayers?[0])! as CALayer
        
        if textField.text != "" {
            
            border.borderColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 0.20).cgColor
            
        } else {
            
            border.borderColor = UIColor.red.withAlphaComponent(0.2).cgColor
            
        }
        
    }
    
    func warningStylingTextField(textField: UITextField) {
        
        let border = (textField.layer.sublayers?[0])! as CALayer
        border.borderColor = UIColor.red.withAlphaComponent(0.2).cgColor
        
    }
    
    func setInitialValue() {
        
        imageProfileView.image = self.imageProfile
        
        nameField.text = name
        
        emailField.text = self.email
        
    }
    
    func stylingProfileImage() {
        
        imageProfileView.layer.cornerRadius = 3
        imageProfileView.layer.borderColor = UIColor.white.cgColor
        imageProfileView.layer.borderWidth = 3
        imageProfileView.layer.masksToBounds = true
        
    }
    
    func addChangeProfileImageGesture() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController2.changeProfilePicture))
        tapGestureRecognizer.numberOfTapsRequired = 1
        imageProfileView.isUserInteractionEnabled = true
        imageProfileView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func changeProfilePicture() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func stylingRadio() {
        
        careerView.layer.cornerRadius = careerView.frame.height / 2
        careerView.layer.masksToBounds = true
        
        studentRadio.layer.cornerRadius = studentRadio.frame.height / 2
        studentRadio.layer.masksToBounds = true
        
        adultRadio.layer.cornerRadius = adultRadio.frame.height / 2
        adultRadio.layer.masksToBounds = true
        
    }
    
    func stylingDoneButton() {
        
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        doneButton.layer.masksToBounds = true
        
    }
    
    func createGradientLayer() {
        
        //Begin, define gradient color shade from RGB(210,116,184) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.82, green: 0.455, blue: 0.72, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.565, green: 0.44, blue: 0.77, alpha: 1).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: topView.bounds.width, height: topView.bounds.height)
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        //End
        
        topView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
