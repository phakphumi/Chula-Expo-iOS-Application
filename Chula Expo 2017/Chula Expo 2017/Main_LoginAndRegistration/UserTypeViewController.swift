//
//  UserTypeViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class UserTypeViewController: UIViewController {

    var token: String!
    var userType = "student"
    var name: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var fbImage: UIImage?
    
    
    @IBOutlet var studentView: UIView!
    @IBOutlet var studentIcon: UIImageView!
    @IBOutlet var studentLabel: UILabel!
    
    @IBOutlet var personView: UIView!
    @IBOutlet var personIcon: UIImageView!
    @IBOutlet var personLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialView()
        
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toRegister", sender: self)
        
    }

    private func initialView() {
    
        studentView.layer.borderWidth = 2
        studentView.layer.borderColor = UIColor(red: 1, green: 0.4275, blue: 0.604, alpha: 1).cgColor
        studentView.layer.cornerRadius = 6
        studentView.layer.masksToBounds = true
        
        let studentTapGesture = UITapGestureRecognizer(target: self, action: #selector(UserTypeViewController.wasTap(gestureRecognizer:)))
        studentView.addGestureRecognizer(studentTapGesture)
        
    
        personView.layer.borderWidth = 0
        personView.layer.borderColor = UIColor(red: 1, green: 0.4275, blue: 0.604, alpha: 1).cgColor
        personView.layer.cornerRadius = 6
        personView.layer.masksToBounds = true
        
        let personTapGesture = UITapGestureRecognizer(target: self, action: #selector(UserTypeViewController.wasTap(gestureRecognizer:)))
        personView.addGestureRecognizer(personTapGesture)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    func wasTap(gestureRecognizer: UITapGestureRecognizer) {
        
        let tapView = gestureRecognizer.view!
        
        if tapView == studentView {
            
            userType = "student"
            
            studentView.layer.borderWidth = 2
            studentView.backgroundColor = nil
            studentIcon.image = #imageLiteral(resourceName: "studentBlack")
            studentLabel.textColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1)
            
            personView.layer.borderWidth = 0
            personView.backgroundColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1)
            personIcon.image = #imageLiteral(resourceName: "personWhite")
            personLabel.textColor = UIColor.white
            
        } else {
            
            userType = "person"
            
            studentView.layer.borderWidth = 0
            studentView.backgroundColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1)
            studentIcon.image = #imageLiteral(resourceName: "studentWhite")
            studentLabel.textColor = UIColor.white
            
            personView.layer.borderWidth = 2
            personView.backgroundColor = nil
            personIcon.image = #imageLiteral(resourceName: "personBlack")
            personLabel.textColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRegister" {
            
            let destination = segue.destination as! RegisterViewController
            
            destination.token = self.token
            destination.userType = self.userType
            destination.name = self.name
            destination.firstName = self.firstName
            destination.lastName = self.lastName
            destination.email = self.email
            destination.fbImage = self.fbImage
            
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
