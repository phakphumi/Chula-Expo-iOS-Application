//
//  RegisterViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var isFrameMove = false
    
    var token: String!
    var userType = "student"
    var name: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    var fbImage: UIImage!
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileImageView: UIView!
    @IBOutlet var cameraIconView: UIView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChangeProfileImageGesture()
        initialValue()
        initialField()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController2.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController2.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        
    }
    
    override func viewDidLayoutSubviews() {

        profileImage.layer.borderColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1).cgColor
        profileImage.layer.borderWidth = 3
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.masksToBounds = true
        
        cameraIconView.layer.cornerRadius = cameraIconView.frame.height / 2
        cameraIconView.layer.masksToBounds = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField.tag == 5 && userType == "person" {
            
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
        
        let heightToDecrease = self.view.bounds.height * 0.15
        
        if !isFrameMove {
            
            isFrameMove = true
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                UIView.animate(withDuration: 0.5, animations: {
                    
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
    
    private func addChangeProfileImageGesture() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.changeProfilePicture))
        tapGestureRecognizer.numberOfTapsRequired = 1
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func changeProfilePicture() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    private func initialValue() {
        
        if self.fbImage != nil {
            
            profileImage.image = self.fbImage
            
        }
        
        firstNameField.text = self.firstName
        lastNameField.text = self.lastName
        emailField.text = self.email
        
    }
    
    private func initialField() {
        
        if userType == "person" {
            
            educationView.alpha = 0
            educationYearView.alpha = 0
            schoolView.alpha = 0
            
            careerView.alpha = 1
            
        }
        
    }
    
}
