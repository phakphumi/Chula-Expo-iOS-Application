//
//  RegisterViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/26/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let genderPicker = UIPickerView()
    let gender = ["Male", "Female"]
    
    var nameView = 0 // 0 = Label, 1 = Text Field
    var careerType = 0 // 0 = Student , 1 = Worker
    var isFrameMove = false // false when frame did not move, true when frame did move
    var name: String!
    var imageProfile: UIImage!
    var activeField: UITextField!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var schoolOrCompanyField: UITextField!
    @IBOutlet var gradeOrPositionField: UITextField!
    
    var imageProfileView: UIImageView!
    var nameLabelView: UILabel!
    var student: UIButton!
    var worker: UIButton!
    
    var studentCheckmark: UIImageView!
    var workerCheckmark: UIImageView!
    
    
    @IBOutlet var schoolOrCompany: UILabel!
    @IBOutlet var gradeOrPosition: UILabel!
    

    @IBAction func nextButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toInterestedView", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createGradientLayer()
        
        createProfileImageView()
        
        createNameLabelView()
        
        createCareerRadio()
        
        emailField.tag = 1
        ageField.tag = 2
        genderField.tag = 3
        schoolOrCompanyField.tag = 4
        gradeOrPositionField.tag = 5        
        
        stylingTextField(textField: emailField)
        stylingTextField(textField: ageField)
        stylingTextField(textField: genderField)
        stylingTextField(textField: schoolOrCompanyField)
        stylingTextField(textField: gradeOrPositionField)
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegisterViewController.doneButtonGenderPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RegisterViewController.cancelButtonGenderPicker))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        genderField.inputAccessoryView = toolbar
        genderField.inputView = genderPicker
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameField {
            
            toggleNameLabel()
            
            textField.resignFirstResponder()
            
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
    
    func cancelButtonGenderPicker() {
        
        genderField.resignFirstResponder()
        
    }
    
    func doneButtonGenderPicker() {
        
        genderField.text = gender[genderPicker.selectedRow(inComponent: 0)]
        
        // Try to find next responder
        if let nextField = self.view.viewWithTag(genderField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
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
    
    func keyboardWillShow(notification: NSNotification) {
        
        let heightToDecrease = self.view.bounds.height * 0.15
        
        if !isFrameMove && activeField != nameField && activeField != genderField{
            
            isFrameMove = true
        
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                self.hideImageView()
                 
                self.moveLabelToCenterOfGradient(movingFrame: keyboardSize.height - heightToDecrease)
                
                UIView.animate(withDuration: 0.5, animations: {
                        
                    self.view.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height - heightToDecrease))
                    
                })
            
            }
            
        } else if activeField == genderField{
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                self.hideImageView()
                
                self.moveLabelToCenterOfGradient(movingFrame: keyboardSize.height - heightToDecrease - (genderPicker.inputAccessoryView?.frame.height)!)
                
                UIView.animate(withDuration: 0.5, animations: {
                        
                    self.view.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height - heightToDecrease - (self.genderPicker.inputAccessoryView?.frame.height)!))
                    
                })
                
            }
            
        }
    
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if isFrameMove && activeField != nameField {
            
            isFrameMove = false
                
            self.showImageView()
            self.moveLabelToBeginning()

            UIView.animate(withDuration: 0.5, animations: {
                    
                self.view.transform = CGAffineTransform(translationX: 0, y: 0)
                    
            })
        
        }
        
    }
    
    func moveLabelToCenterOfGradient(movingFrame: CGFloat) {
        
        let nameLabelViewTopMargin = self.view.bounds.height * 0.285
        let gradientHeight = self.view.bounds.height * 0.352
        
        let remainingNameLabelViewTopMargin = nameLabelViewTopMargin - movingFrame
        let remainingGradientHeight = gradientHeight - movingFrame - UIApplication.shared.statusBarFrame.height
        
        let movingLabel = remainingGradientHeight / 2 - remainingNameLabelViewTopMargin
        
        UIView.animate(withDuration: 0.5) {
            
            self.nameLabelView.transform = CGAffineTransform(translationX: 0, y: movingLabel)
            
        }
        
        
    }
    
    func moveLabelToBeginning() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.nameLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
            
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
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        
    }
    
    func createCareerRadio() {
        
        let careerViewWidth = self.view.bounds.width * 0.82
        let careerViewHeight = CGFloat(28)
        let careerViewTopMargin = self.view.bounds.height * 0.39
        
        let careerView = UIView(frame: CGRect(x: self.view.bounds.width / 2 - careerViewWidth / 2, y: careerViewTopMargin, width: careerViewWidth, height: careerViewHeight))
        careerView.layer.backgroundColor = UIColor(red: 0.8863, green: 0.53725, blue: 0.7961, alpha: 1).cgColor
        careerView.layer.cornerRadius = careerViewHeight / 2
        
        let buttonWidth = careerView.bounds.width / 2 - 2
        let buttonHeight = careerViewHeight - 2
        
        student = UIButton(frame: CGRect(x: 1, y: 1, width: buttonWidth, height: buttonHeight))
        student.layer.cornerRadius = buttonHeight / 2
        student.layer.backgroundColor = UIColor.white.cgColor
        student.setTitle("Student", for: .normal)
        student.setTitleColor(UIColor.black, for: .normal)
        
        
        worker = UIButton(frame: CGRect(x: careerView.bounds.width / 2 + 1, y: 1, width: buttonWidth, height: buttonHeight))
        worker.layer.cornerRadius = buttonHeight / 2
        worker.layer.backgroundColor = nil
        worker.setTitle("Worker", for: .normal)
        worker.setTitleColor(UIColor.white, for: .normal)
        
        studentCheckmark = UIImageView(frame: CGRect(x: 8, y: 6, width: 18, height: 16))
        studentCheckmark.image = UIImage(named: "register_checkmark.png")
        
        workerCheckmark = UIImageView(frame: CGRect(x: careerView.bounds.width / 2 + 8, y: 6, width: 18, height: 16))
        workerCheckmark.image = nil
        
        careerView.addSubview(student)
        careerView.addSubview(worker)
        careerView.addSubview(studentCheckmark)
        careerView.addSubview(workerCheckmark)
        
        self.view.addSubview(careerView)
        
        student.addTarget(self, action: #selector(RegisterViewController.tapOnCareerRadio), for: .touchUpInside)
        worker.addTarget(self, action: #selector(RegisterViewController.tapOnCareerRadio), for: .touchUpInside)
        
    }
    
    func tapOnCareerRadio() {
        
        if careerType == 1 {
            
            careerType = 0 // set to student
            
            worker.setTitleColor(UIColor.white, for: .normal)
            worker.layer.backgroundColor = nil
            workerCheckmark.image = nil
            
            student.setTitleColor(UIColor.black, for: .normal)
            student.layer.backgroundColor = UIColor.white.cgColor
            studentCheckmark.image = UIImage(named: "register_checkmark.png")
            
            
            schoolOrCompany.text = "SCHOOL/UNIVERSITY"
            schoolOrCompanyField.placeholder = "Chulalongkorn University"
            
            gradeOrPosition.text = "GRADE/YEAR"
            gradeOrPositionField.placeholder = "3"
            
        } else {
            
            careerType = 1 // set to worker
            
            student.setTitleColor(UIColor.white, for: .normal)
            student.layer.backgroundColor = nil
            studentCheckmark.image = nil
            
            worker.setTitleColor(UIColor.black, for: .normal)
            worker.layer.backgroundColor = UIColor.white.cgColor
            workerCheckmark.image = UIImage(named: "register_checkmark.png")
            
            schoolOrCompany.text = "COMPANY/ORGANIZATION"
            schoolOrCompanyField.placeholder = "Example Company"
            
            gradeOrPosition.text = "POSITION"
            gradeOrPositionField.placeholder = "Software Engineering"
            
        }
        
    }
    
    func createNameLabelView() {
        
        let nameLabelViewWidth = self.view.bounds.width * 0.85
        let nameLabelViewHegiht = CGFloat(30)
        let nameLabelViewTopMargin = self.view.bounds.height * 0.285
        
        nameField.frame = CGRect(x: self.view.bounds.width / 2 - nameLabelViewWidth / 2 + 500, y: nameLabelViewTopMargin, width: nameLabelViewWidth, height: nameLabelViewHegiht)
        
        nameLabelView = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - nameLabelViewWidth / 2, y: nameLabelViewTopMargin, width: nameLabelViewWidth, height: nameLabelViewHegiht))
        nameLabelView.font = nameLabelView.font.withSize(25)
        nameLabelView.textAlignment = NSTextAlignment.center
        nameLabelView.textColor = UIColor.white
        nameLabelView.text = name
        
        //Begin, create tap gestureRecognizer to select item
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.toggleNameLabel))
        tapGestureRecognizer.numberOfTapsRequired = 1
        nameLabelView.isUserInteractionEnabled = true
        nameLabelView.addGestureRecognizer(tapGestureRecognizer)
        //End
        
        self.view.addSubview(nameLabelView)
        
    }
    
    func toggleNameLabel() {
        
        if nameView == 0 {
            
            nameView = 1
        
            nameField.text = nameLabelView.text
            
            nameField.becomeFirstResponder()
        
            UIView.animate(withDuration: 0.5) {
            
                self.nameField.transform = CGAffineTransform(translationX: -500, y: 0)
            
                self.nameLabelView.transform = CGAffineTransform(translationX: -500, y: 0)
            
            }
            
        } else {
            
            nameView = 0
            
            nameLabelView.text = nameField.text
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.nameField.transform = CGAffineTransform(translationX: 0, y: 0)
                
                self.nameLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            })
            
        }
        
    }
    
    func createProfileImageView() {
        
        let imageViewWidthAndHeight = self.view.bounds.height * 0.21
        let imageViewTopMargin = self.view.bounds.height * 0.064
        
        imageProfileView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - imageViewWidthAndHeight / 2, y: imageViewTopMargin, width: imageViewWidthAndHeight, height: imageViewWidthAndHeight))
        imageProfileView.image = self.imageProfile
        imageProfileView.layer.cornerRadius = imageProfileView.bounds.height / 2
        imageProfileView.layer.borderColor = UIColor.white.cgColor
        imageProfileView.layer.borderWidth = 3
        imageProfileView.layer.masksToBounds = true
        
        self.view.addSubview(imageProfileView)
        
    }
    
    func createGradientLayer() {
        
        //Begin, define gradient layer scale
        let gradientWidth = self.view.bounds.width
        let gradientHeight = self.view.bounds.height * 0.352
        //End, define
        
        //Begin, define gradient color shade from RGB(210,116,184) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.82, green: 0.455, blue: 0.72, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.565, green: 0.44, blue: 0.77, alpha: 1).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientWidth, height: gradientHeight)
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        //End
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
