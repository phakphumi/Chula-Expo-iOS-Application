//
//  UsernameLoginViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 3/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import Alamofire
import Answers
import CoreData

class UsernameLoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var managedObjectContext: NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()

        Answers.logContentView(withName: "Username Login",
                               contentType: nil,
                               contentId: nil,
                               customAttributes: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let parameters: [String: Any] = [
            "email": username.text ?? "",
            "password": password.text ?? "",
        ]

        Alamofire.request("https://api.chulaexpo.com/api/login", method: .post, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let JSON = response.result.value as! NSDictionary
                
                if JSON["success"] as! Bool {
                    
                    let result = JSON["results"] as! NSDictionary
                    
                    let token = result["token"] as? String ?? ""
                    
                    let header: HTTPHeaders = ["Authorization": "JWT \(token)"]
                    
                    Alamofire.request("https://staff.chulaexpo.com/api/me", headers: header).responseJSON { response in
                        
                        if response.result.isSuccess {
                            
                            let JSON = response.result.value as! NSDictionary
                            
                            if JSON["success"] as! Bool {
                                
                                if let results = JSON["results"] as? NSDictionary {
                                    
                                    let academic = results["academic"] as? [String: String]
                                    
                                    let worker = results["worker"] as? [String: String]
                                    
                                    self.managedObjectContext?.performAndWait {
                                        
                                        _ = UserData.addUser(id: results["_id"] as! String,
                                                             token: token,
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
                                                             inManageobjectcontext: self.managedObjectContext!
                                        )
                                        
                                    }
                                    
                                    do {
                                        
                                        try self.managedObjectContext?.save()
                                        print("saved user")
                                        
                                    } catch let error {
                                        
                                        print("saveUserError with \(error)")
                                        
                                    }
                                    
                                    
                                }
                                
                                Answers.logLogin(withMethod: "Username Log in", success: true, customAttributes: nil)
                                
                                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                                
                            } else {
                                
                                let error = JSON["errors"] as! NSDictionary
                                let message = error["message"] as? String ?? ""
                                
                                let confirm = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                                
                                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                
                                self.present(confirm, animated: true, completion: nil)
                                
                                Answers.logLogin(withMethod: "Username Log in", success: false, customAttributes: nil)
                                
                                
                            }
                            
                        } else {
                            
                            let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                            
                            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            
                            self.present(confirm, animated: true, completion: nil)
                            
                            Answers.logLogin(withMethod: "Username Log in", success: false, customAttributes: nil)
                            
                        }
                        
                    }

                    
                } else {
                    
                   let alert = UIAlertController(title: "ล้มเหลว", message: "ชื่อผู้ใช้/รหัสผ่านผิดพลาด", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        
                        Answers.logLogin(withMethod: "Username Log in", success: false, customAttributes: nil)
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
     
        self.dismiss(animated: true, completion: nil)
        
    }

}
