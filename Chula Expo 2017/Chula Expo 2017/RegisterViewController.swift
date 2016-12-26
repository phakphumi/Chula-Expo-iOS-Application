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
    
    var careerType = 0 // 0 = Student , 1 = Worker
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var schoolOrCompanyField: UITextField!
    @IBOutlet var gradeOrPositionField: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var student: UIButton!
    @IBOutlet var worker: UIButton!
    
    @IBOutlet var studentCheckmark: UIImageView!
    @IBOutlet var workerCheckmark: UIImageView!
    
    
    @IBOutlet var schoolOrCompany: UILabel!
    @IBOutlet var gradeOrPosition: UILabel!
    

    @IBAction func doneButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toInterestedView", sender: self)
        
    }
    
    @IBAction func selectStudent(_ sender: UIButton) {
        
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
            
        }
        
    }
    
    
    @IBAction func selectWorker(_ sender: Any) {
        
        if careerType == 0 {
            
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.shared.statusBarStyle = .lightContent
        
        createGradientLayer()
        
        stylingProfileImage()
        
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
        genderField.inputView = genderPicker
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        genderField.text = gender[row]
        
        // Try to find next responder
        if let nextField = self.view.viewWithTag(genderField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            // Not found, so remove keyboard.
            genderField.resignFirstResponder()
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            
        }
        
        return false

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func stylingProfileImage() {
        
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 3
        profileImage.layer.masksToBounds = true
        
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
