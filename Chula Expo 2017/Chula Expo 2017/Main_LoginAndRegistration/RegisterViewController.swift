//
//  RegisterViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var isFrameMove = false
    var activeField = UITextField()
    
    var userType: String!
    var name: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    var fbId: String!
    var fbToken: String!
    var fbImageProfileUrl: String?
    var fbImage: UIImage!
    var managedObjectContext: NSManagedObjectContext?
    
    var userToken: String?
    
    let gender = ["-", "ชาย", "หญิง", "อื่น ๆ"]
    let education = ["มัธยมต้น", "มัธยมปลาย", "ปริญญาตรี", "ปริญญาโท", "ปริญญาเอก", "อื่น ๆ"]
    let educationYear = ["มัธยมต้น": ["ม.1", "ม.2", "ม.3"],
                         "มัธยมปลาย": ["ม.4", "ม.5", "ม.6"],
                         "ปริญญาตรี": ["ปี 1", "ปี 2", "ปี 3", "ปี 4", "ปี 5", "ปี 6", "ปี 7", "ปี 8"],
                         "ปริญญาโท": ["ปี 1", "ปี 2", "ปี 3", "ปี 4"],
                         "ปริญญาเอก": ["ปี 1", "ปี 2", "ปี 3", "ปี 4"],
                         "อื่น ๆ": ["ปี 1", "ปี 2", "ปี 3", "ปี 4", "ปี 5", "ปี6"]]
    let career = ["เกษตรกร‎",
                  "เจ้าหน้าที่รัฐบาล‎",
                  "เภสัชกร‎",
                  "แพทย์",
                  "โฆษก‎",
                  "โปรแกรมเมอร์",
                  "กวี‎",
                  "การประมง‎",
                  "การฝีมือ‎",
                  "การส่งเสริมอาชีพ‎",
                  "ข้าราชการ‎",
                  "คนขับรถแท็กซี่‎",
                  "ครู",
                  "คอลัมนิสต์‎",
                  "จิตรกร‎",
                  "ช่างทำเครื่องดนตรี‎",
                  "ช่างทำผม‎",
                  "ตำรวจ‎",
                  "ตุลาการ‎",
                  "ทนายความ‎",
                  "ทหาร",
                  "ธุรกิจส่วนตัว",
                  "นักเขียน‎",
                  "นักเขียนบทภาพยนตร์",
                  "นักเคลื่อนไหว‎",
                  "นักเศรษฐศาสตร์",
                  "นักแต่งเพลง",
                  "นักแปล",
                  "นักแสดง‎",
                  "นักโบราณคดี",
                  "นักโภชนาการ",
                  "นักกฎหมาย‎",
                  "นักการเมือง‎",
                  "นักการกุศล‎",
                  "นักการทูต‎",
                  "นักการธนาคาร‎",
                  "นักการศึกษา‎",
                  "นักกีฬา‎",
                  "นักข่าว",
                  "นักคณิตศาสตร์‎",
                  "นักจัดรายการวิทยุ‎",
                  "นักจิตวิทยา",
                  "นักชีววิทยา‎",
                  "นักดนตรี‎",
                  "นักดาราศาสตร์‎",
                  "นักถ่ายภาพ‎",
                  "นักธุรกิจ‎",
                  "นักบวช‎",
                  "นักบัญชี",
                  "นักบิน‎",
                  "นักบินอวกาศ‎",
                  "นักประชาสัมพันธ์‎",
                  "นักประดิษฐ์",
                  "นักประวัติศาสตร์",
                  "นักประวัติศาสตร์ศิลป์‎",
                  "นักปรัชญา",
                  "นักปีนเขา",
                  "นักผจญภัย‎",
                  "นักพากย์",
                  "นักภาษาศาสตร์",
                  "นักมายากล‎",
                  "นักร้อง",
                  "นักวาดการ์ตูน",
                  "นักวิจารณ์ภาพยนตร์",
                  "นักวิทยาศาสตร์",
                  "นักสะสมศิลปะ",
                  "นักสังคมวิทยา",
                  "นักสังคมศาสตร์",
                  "นักสัตววิทยา",
                  "นักสำรวจ",
                  "นักสืบ",
                  "นักหนังสือพิมพ์‎",
                  "นักอนุรักษ์ธรรมชาติ",
                  "นักออกแบบ",
                  "นักออกแบบเสื้อผ้า‎",
                  "นักออกแบบกราฟิก‎",
                  "นางแบบ",
                  "นางงาม",
                  "นายแบบ",
                  "บรรณาธิการ",
                  "บุคคลในวงการคอมพิวเตอร์‎",
                  "บุคคลในวงการพลศึกษา",
                  "บุคคลในวงการวรรณกรรม",
                  "บุคคลด้านสื่อ",
                  "ผู้เชี่ยวชาญด้านศาสนาพุทธ",
                  "ผู้กำกับ",
                  "ผู้กำกับภาพยนตร์",
                  "ผู้กำกับละครโทรทัศน์‎",
                  "ผู้จัดพิมพ์ (บุคคล)‎",
                  "ผู้ประกาศข่าว",
                  "ผู้พิพากษาไทย‎",
                  "ผู้มีชื่อเสียง",
                  "ผู้อำนวยการสร้างภาพยนตร์",
                  "พยาบาล",
                  "พิธีกร",
                  "ฟรีแลนซ์",
                  "ภูมิสถาปนิก",
                  "รัฐวิสาหกิจ",
                  "ว่างงาน",
                  "วาทยกร",
                  "วิชาชีพทางด้านสาธารณสุข",
                  "วิศวกร",
                  "วีเจ",
                  "ศิลปิน",
                  "สถาปนิก",
                  "อัยการ",
                  "อาจารย์",
                  "อาชีพการเดินเรือ",
                  "อาชีพการบันเทิง",
                  "อาชีพด้านอาหาร",
                  "อื่น ๆ"]
    
    let agePicker = UIPickerView()
    let genderPicker = UIPickerView()
    let educationPicker = UIPickerView()
    let educationYearPicker = UIPickerView()
    let careerPicker = UIPickerView()
    
    @IBOutlet var numberLabel: UILabel!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var educationView: UIView!
    @IBOutlet var educationYearView: UIView!
    @IBOutlet var schoolView: UIView!
    @IBOutlet var careerView: UIView!
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var educationField: UITextField!
    @IBOutlet var educationYearField: UITextField!
    @IBOutlet var schoolField: UITextField!
    @IBOutlet var careerField: UITextField!
    
    var toEdit = false
    var userData: UserData?
    
    @IBOutlet weak var cancelEdit: UIButton!
    @IBOutlet weak var saveEdit: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toEdit {
            
            nextButton.isHidden = true
            
            cancelEdit.isHidden = false
            saveEdit.isHidden = false
            
        }

//        addChangeProfileImageGesture()
        initialValue()
        initialField()
        initialPicker()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        
    }
    
    override func viewDidLayoutSubviews() {

        numberLabel.layer.cornerRadius = numberLabel.frame.height / 2
        
        
        profileImage.layer.borderColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1).cgColor
        profileImage.layer.borderWidth = 3
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.masksToBounds = true
        
//        cameraIconView.layer.cornerRadius = cameraIconView.frame.height / 2
//        cameraIconView.layer.masksToBounds = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toInterested" {
            
            let destination = segue.destination as! interestViewController
            
            destination.userType = self.userType
            destination.name = "\(firstNameField.text!) \(lastNameField.text!)"
            destination.email = emailField.text
            destination.age = ageField.text
            destination.gender = genderField.text
            destination.fbId = self.fbId
            destination.fbToken = self.fbToken
            destination.fbImageProfileUrl = self.fbImageProfileUrl!
            destination.fbImage = self.fbImage!
            destination.managedObjectContext = self.managedObjectContext
            
            
            if self.userType == "Academic" {
                
                destination.education = educationField.text
                destination.educationYear = educationYearField.text
                destination.school = schoolField.text
                destination.career = ""
                
            } else {
                
                destination.education = ""
                destination.educationYear = ""
                destination.school = ""
                destination.career = careerField.text
                
            }
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeField = textField
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField.tag == 5 && userType == "Worker" {
            
            let nextField = self.view.viewWithTag(10) as! UITextField
            
            nextField.becomeFirstResponder()
            
        } else if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            
        }
        
        return false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {

        
        if !isFrameMove {
            
            let heightToDecrease = self.view.bounds.height * 0.15
            
            isFrameMove = true
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {

                UIView.animate(withDuration: 0.1, animations: {
                    
                    self.view.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height - heightToDecrease))
                    
                })
                
            }
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if isFrameMove {
            
            isFrameMove = false
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.view.transform = CGAffineTransform(translationX: 0, y: 0)
                
            })
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profileImage.image = image
            
        } else {
            
            print("error while access photo library")
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == agePicker {
        //age
            return 100
            
        } else if pickerView == genderPicker {
            
            return gender.count
            
        } else if pickerView == educationPicker {
            
            return education.count
            
        } else if pickerView == educationYearPicker {
            
            return educationYear[educationField.text!]!.count
            
        } else {
            
            return career.count
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == agePicker {
        
            if row == 0 {
                
                return "-"
                
            } else {
                
                return "\(row + 10)"
                
            }
            
        } else if pickerView == genderPicker {
        
            return gender[row]
            
        } else if pickerView == educationPicker {
            
            return education[row]
            
        } else if pickerView == educationYearPicker {
            
            return educationYear[educationField.text!]?[row]
            
        } else {
            
            return career[row]
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == agePicker {
            
            if row == 0 {
                
                ageField.text = "-"
                
            } else {
                
                ageField.text = "\(row + 10)"
                
            }
            
        } else if pickerView == genderPicker {
            
            genderField.text = gender[row]
            
        } else if pickerView == educationPicker {
            
            educationField.text = education[row]
            
            educationYearField.text = educationYear[educationField.text!]?[0]
            educationYearPicker.selectRow(0, inComponent: 0, animated: false)
            
        } else if pickerView == educationYearPicker {
            
            educationYearField.text = educationYear[educationField.text!]?[row]
            
        } else {
            
            careerField.text = career[row]
            
        }
        
    }
    
//    private func addChangeProfileImageGesture() {
//        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.changeProfilePicture))
//        tapGestureRecognizer.numberOfTapsRequired = 1
//        profileImage.isUserInteractionEnabled = true
//        profileImage.addGestureRecognizer(tapGestureRecognizer)
//        
//    }
    
//    func changeProfilePicture() {
//        
//        let imagePickerController = UIImagePickerController()
//        
//        imagePickerController.delegate = self
//        
//        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        
//        imagePickerController.allowsEditing = false
//        
//        self.present(imagePickerController, animated: true, completion: nil)
//        
//    }
    
    private func initialValue() {
        
        if self.fbImage != nil {
            
            profileImage.image = self.fbImage
            
        }
        
        if toEdit {
            
            if let facebookProfileUrl = URL(string: (userData?.profile)!) {
                
                if let data = NSData(contentsOf: facebookProfileUrl) {
                    
                    profileImage.image = UIImage(data: data as Data)
                    
                }   
                
            }
            
            if let name = userData?.name?.components(separatedBy: " ") {
                
                if name.count > 1 {
            
                    self.firstNameField.text = name[0]
                    self.lastNameField.text = name[1]
                    
                } else {
                    
                    self.firstNameField.text = name[0]
                    
                }
                
            }
            
            if let gender = userData?.gender {
                
                if gender == "Male" {
                    
                    self.genderField.text = "ชาย"
                    
                } else if gender == "Female" {
                    
                    self.genderField.text = "หญิง"
                    
                } else {
                    
                    self.genderField.text = "อื่น ๆ"
                    
                }
                
            }
            
            self.emailField.text = userData?.email
            self.ageField.text = String(Int((userData?.age)!))
            self.careerField.text = userData?.job
            self.educationYearField.text = userData?.year
            self.educationField.text = userData?.level
            self.schoolField.text = userData?.school
            
        } else {
            
            firstNameField.text = self.firstName
            lastNameField.text = self.lastName
            emailField.text = self.email
            
        }
        
    }
    
    private func initialField() {
//        if let UT: String = userType {
        
            if userType == "Worker" {
                
                educationView.alpha = 0
                educationYearView.alpha = 0
                schoolView.alpha = 0
                
                careerView.alpha = 1
                
            }
//        }


        
    }
    
    private func initialPicker() {
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegisterViewController.pickerNext))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([spaceButton, nextButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        agePicker.delegate = self
        agePicker.dataSource = self
        ageField.inputView = agePicker
        ageField.inputAccessoryView = toolbar
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderField.inputView = genderPicker
        genderField.inputAccessoryView = toolbar
        
        educationPicker.delegate = self
        educationPicker.dataSource = self
        educationField.inputView = educationPicker
        educationField.inputAccessoryView = toolbar
        
        educationYearPicker.delegate = self
        educationYearPicker.dataSource = self
        educationYearField.inputView = educationYearPicker
        educationYearField.inputAccessoryView = toolbar
        
        careerPicker.delegate = self
        careerPicker.dataSource = self
        careerField.inputView = careerPicker
        careerField.inputAccessoryView = toolbar
        
    }
    
    func pickerNext() {
        
        if activeField.tag == 5 && userType == "Worker" {
            
            let nextField = self.view.viewWithTag(10) as! UITextField
            
            nextField.becomeFirstResponder()
            
        } else if let nextField = self.view.viewWithTag(activeField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            // Not found, so remove keyboard.
            activeField.resignFirstResponder()
            
        }
        
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        if userType == "Academic" {
            
            if firstNameField.text == "" || lastNameField.text == "" || emailField.text == "" || ageField.text == "" || genderField.text == "" || educationField.text == "" || educationYearField.text == "" || schoolField.text == "" {
                
                let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "กรุณากรอกข้อมูลให้ครบถ้วน", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(confirm, animated: true, completion: nil)

                
            } else {
                
                self.performSegue(withIdentifier: "toInterested", sender: self)
                
            }
            
        } else {
            
            if firstNameField.text == "" || lastNameField.text == "" || emailField.text == "" || ageField.text == "" || genderField.text == "" || careerField.text == "" {
                
                let confirm = UIAlertController(title: "เกิดข้อผิดพลาด", message: "กรุณากรอกข้อมูลให้ครบถ้วน", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(confirm, animated: true, completion: nil)
                
            } else {
                
                self.performSegue(withIdentifier: "toInterested", sender: self)
                
            }
            
        }
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if self.genderField.text == "ชาย" {
            
            self.genderField.text = "Male"
            
        } else if self.genderField.text == "หญิง" {
            
            self.genderField.text = "Female"
            
        } else {
            
            self.genderField.text = "Other"
            
        }
        
        if self.ageField.text == "-" {
            
            self.ageField.text = "0"
            
        }
        
        var parameters = [String: Any]()
        
        if self.userType == "Academic" {
            
            if let academicLevel = self.educationField.text,
                let academicYear = self.educationYearField.text,
                let academicSchool = self.schoolField.text,
                let gender = self.genderField.text
            {
                    
                    parameters = [
                        "type": "Academic",
                        "name": "\(self.firstNameField.text!) \(self.lastNameField.text!)",
                        "email": self.emailField.text!,
                        "age": Int(self.ageField.text!) ?? 0,
                        "academicLevel": academicLevel,
                        "academicYear": academicYear,
                        "academicSchool": academicSchool,
                        "gender": gender
                    ]
                    
            }
            
        } else {
            
            if let career = self.careerField.text,
                let gender = self.genderField.text
            {
                    
                parameters = [
                                "type": "Worker",
                                "name": "\(self.firstNameField.text!) \(self.lastNameField.text!)",
                                "email": self.emailField.text!,
                                "age": Int(self.ageField.text!) ?? 0,
                                "workerJob": career,
                                "gender": gender
                            ]
    
            }
    
        }
        
        let header: HTTPHeaders = ["Authorization": "JWT \((userData?.token)!)"]
        
        Alamofire.request("https://staff.chulaexpo.com/api/me", method: .put, parameters: parameters, headers: header).responseJSON { response in
        
            if response.result.isSuccess {
                
                Alamofire.request("https://staff.chulaexpo.com/api/me", headers: header).responseJSON { response in
                    
                    if response.result.isSuccess {
                        
                        let JSON = response.result.value as! NSDictionary
                        
                        if let results = JSON["results"] as? NSDictionary{
                            
                            let academic = results["academic"] as? [String: String]
                            
                            let worker = results["worker"] as? [String: String]
                            
                            let managedObjectContext: NSManagedObjectContext? =
                                (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
                            
                            managedObjectContext?.performAndWait {
                                
                                _ = UserData.addUser(id: results["_id"] as! String,
                                                     token: "",
                                                     type: results["type"] as! String,
                                                     name: results["name"] as! String,
                                                     email: results["email"] as! String,
                                                     age: results["age"] as! Int,
                                                     gender: results["gender"] as! String,
                                                     school: academic?["school"] ?? "",
                                                     level: academic?["level"] ?? "",
                                                     year: academic?["year"] ?? "",
                                                     job: worker?["job"] ?? "",
                                                     profile: results["profile"] as? String ?? "",
                                                     inManageobjectcontext: managedObjectContext!
                                )
                                
                            }
                            
                            do {
                                
                                try managedObjectContext?.save()
                                print("saved user")
                                
                            } catch let error {
                                
                                print("saveUserError with \(error)")
                                
                            }
                            
                        }
                        
                        self.performSegue(withIdentifier: "endEdit", sender: self)
                        
                    } else {
                        
                        let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(confirm, animated: true, completion: nil)
                        
                        
                    }
                    
                }
            
            } else {
                
                let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(confirm, animated: true, completion: nil)
                
            }
            
        }
        
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
