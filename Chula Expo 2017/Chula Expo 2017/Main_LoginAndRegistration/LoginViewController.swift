//
//  LoginViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/29/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CoreData
import Alamofire
//import Crashlytics // If using Answers with Crashlytics
import Answers // If using Answers without Crashlytics


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var fbToken: String?
    var name: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var fbId: String?
    var fbImageProfileUrl: String?
    var fbImage: UIImage!
    
    let managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Track the user action that is important for you.
        Answers.logContentView(withName: "Login",
                               contentType: nil,
                               contentId: nil,
                               customAttributes: nil)
        
        UIApplication.shared.statusBarStyle = .lightContent
            
        if FBSDKAccessToken.current() != nil {
            
            checkRegisterStatus(completion: { (success, token) in
                
                if success {
                    
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
                                
                                Answers.logLogin(withMethod: "Auto Log in", success: true, customAttributes: nil)
                                
                                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                                
                            } else {
                                
                                let error = JSON["errors"] as! NSDictionary
                                let message = error["message"] as? String ?? ""
                                
                                let confirm = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                                
                                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                
                                self.present(confirm, animated: true, completion: nil)
                                
                                Answers.logLogin(withMethod: "Auto Log in", success: false, customAttributes: nil)
                                
                                
                            }
                            
                        } else {
                            
                            let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                            
                            confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            
                            self.present(confirm, animated: true, completion: nil)
                            
                            Answers.logLogin(withMethod: "Auto Log in", success: false, customAttributes: nil)
                            
                        }
                        
                    }

                } else {
                    
                    Answers.logSignUp(withMethod: "Auto Sign up", success: true, customAttributes: nil)
                    
                    self.prepareToRegister()
                    
                }
                
            })
            
        } else {
            
            createFacebookLoginButton()
            
            createGuestLoginButton()
            
            createUsernameLoginButton()
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toUserType" {
            
            let navigationController = segue.destination as! UINavigationController
            
            let destination = navigationController.viewControllers.first as! UserTypeViewController
            
            destination.name = self.name
            destination.firstName = self.firstName
            destination.lastName = self.lastName
            destination.email = self.email
            destination.fbId = self.fbId
            destination.fbToken = self.fbToken
            destination.fbImageProfileUrl = self.fbImageProfileUrl
            destination.fbImage = self.fbImage
            destination.managedObjectContext = self.managedObjectContext
            
        } else if segue.identifier == "toUsernameLogin" {
            
            if let destination = segue.destination as? UsernameLoginViewController {
                
                destination.managedObjectContext = self.managedObjectContext
                
            }
            
        }
        
    }
    
    func prepareToRegister() {
        
        if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email, name, first_name, last_name"]) {
            
            graphRequest.start(completionHandler: { (connection, result, error) in
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let userDetails = result as? [String: String] {
                        
                        self.fbToken = FBSDKAccessToken.current().tokenString
                        
                        self.name = userDetails["name"]
                            
                        self.firstName = userDetails["first_name"]
                            
                        self.lastName = userDetails["last_name"]
                            
                        self.email = userDetails["email"]
                        
                        self.fbId = userDetails["id"]
                        
                        self.fbImageProfileUrl = "https://graph.facebook.com/\(userDetails["id"]!)/picture?type=large"
                        
                        self.setImageProfile()
                        
                        self.performSegue(withIdentifier: "toUserType", sender: self)
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    func usernameLogin() {
        
        self.performSegue(withIdentifier: "toUsernameLogin", sender: self)
        
    }
    
    func guestLogin() {
        
        self.name = "Yourname Lastname"
        self.fbImage = UIImage(named: "chula_expo_logo.jpg")
        
        Answers.logLogin(withMethod: "Guest Log in", success: true, customAttributes: nil)
        
        performSegue(withIdentifier: "toHomeScreen", sender: self)
        
    }
    
    func facebookLogin() {
        
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result , error) in

            if error != nil {
                
                print(error!)
                
            } else if (result?.isCancelled)! {
                
                print("User cancelled login")
                
            } else {
                
                if (result?.grantedPermissions.contains("email"))! {
                    
                    self.checkRegisterStatus(completion: { (success, token) in
                    
                        if success {
                            
                            let header: HTTPHeaders = ["Authorization": "JWT \(token)"]
                            
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
                                    
                                    self.managedObjectContext?.performAndWait {
                                        
                                        APIController.downloadReserved(inManageobjectcontext: self.managedObjectContext!)
                                        
                                    }
                                    
                                    Answers.logLogin(withMethod: "Log in", success: true, customAttributes: nil)
                                    
                                    self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                                    
                                } else {
                                    
                                    let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                    
                                    self.present(confirm, animated: true, completion: nil)

                                    
                                    Answers.logLogin(withMethod: "Log in", success: false, customAttributes: nil)
                                    
                                }
                                
                            }
                            
                            
                        } else {
                            
                            Answers.logSignUp(withMethod: "Sign Up", success: true, customAttributes: nil)
                            
                            self.prepareToRegister()
                            
                        }

                    })
                    
                }
                
            }
            
        }

    }
    
    private func checkRegisterStatus(completion:@escaping (Bool, String) -> Void) {
        
        Alamofire.request("https://staff.chulaexpo.com/auth/facebook/token?access_token=\(FBSDKAccessToken.current().tokenString!)").responseJSON { response in
print("https://staff.chulaexpo.com/auth/facebook/token?access_token=\(FBSDKAccessToken.current().tokenString!)")
print(response)
            if response.result.isSuccess {
            
                let JSON = response.result.value as! NSDictionary
            
                let success = JSON["success"] as! Bool
            
                if success {
                
                    if let token = (JSON["results"] as! NSDictionary)["token"] as? String{
                    
                        completion(success, token)
                    
                    }
                
                } else {
                
                    completion(success, "")
                
                }
                
            } else {
                
                let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(confirm, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func setImageProfile() {
        
        let facebookProfileUrl = URL(string: fbImageProfileUrl!)
        
        if let data = NSData(contentsOf: facebookProfileUrl!) {
            
            self.fbImage = UIImage(data: data as Data)
            
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
    }
    
    func createUsernameLoginButton() {
        
        let usernameLoginViewWidth = self.view.bounds.width * 0.8
        let usernameLoginViewHeight = self.view.bounds.height * 0.093
        let usernameLoginViewTopMargin = self.view.bounds.height * 0.80
        
        let usernameLoginView = UIView(frame: CGRect(x: self.view.bounds.width / 2 - usernameLoginViewWidth / 2, y: usernameLoginViewTopMargin, width: usernameLoginViewWidth, height: usernameLoginViewHeight))
        usernameLoginView.layer.cornerRadius = 2
        //        facebookLoginView.layer.cornerRadius = facebookLoginViewHeight / 2
        usernameLoginView.layer.backgroundColor = UIColor(red:0.78, green:0.25, blue:0.44, alpha:1.0).cgColor
        
        let usernameLoginButton = UIButton(frame: CGRect(x: 0, y: 0, width: usernameLoginViewWidth, height: usernameLoginViewHeight))
        
        if self.view.bounds.height >= 667 {
            
            usernameLoginButton.titleLabel?.font = usernameLoginButton.titleLabel?.font.withSize(20)
            
        } else {
            
            usernameLoginButton.titleLabel?.font = usernameLoginButton.titleLabel?.font.withSize(17)
            
        }
        
        let usernameLoginButtonOffset = usernameLoginView.bounds.width * 0.125
        usernameLoginButton.setTitle("Login with Username", for: .normal)
        usernameLoginButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: usernameLoginButtonOffset, bottom: 0, right: 0)
        //        facebookLoginButton.setTitleColor(UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1), for: .highlighted)
        usernameLoginButton.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .highlighted)
        
        let loginLogoOffset = usernameLoginView.bounds.width * 0.11
        let loginLogo = UIImageView(frame: CGRect(x: loginLogoOffset, y: usernameLoginView.bounds.height / 2 - 27 / 2, width: 27, height: 27))
        loginLogo.image = UIImage(named: "user_login_icon")
        
        usernameLoginView.addSubview(loginLogo)
        usernameLoginView.addSubview(usernameLoginButton)
        
        self.view.addSubview(usernameLoginView)
        
        usernameLoginButton.addTarget(self, action: #selector(LoginViewController.usernameLogin), for: .touchUpInside)
        
    }

    
    func createFacebookLoginButton() {
        
        let facebookLoginViewWidth = self.view.bounds.width * 0.8
        let facebookLoginViewHeight = self.view.bounds.height * 0.093
        let facebookLoginViewTopMargin = self.view.bounds.height * 0.69
        
        let facebookLoginView = UIView(frame: CGRect(x: self.view.bounds.width / 2 - facebookLoginViewWidth / 2, y: facebookLoginViewTopMargin, width: facebookLoginViewWidth, height: facebookLoginViewHeight))
        facebookLoginView.layer.cornerRadius = 2
//        facebookLoginView.layer.cornerRadius = facebookLoginViewHeight / 2
        facebookLoginView.layer.backgroundColor = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0).cgColor
        
        let facebookLoginButton = UIButton(frame: CGRect(x: 0, y: 0, width: facebookLoginViewWidth, height: facebookLoginViewHeight))
        
        if self.view.bounds.height >= 667 {
            
            facebookLoginButton.titleLabel?.font = facebookLoginButton.titleLabel?.font.withSize(20)
            
        } else {
            
            facebookLoginButton.titleLabel?.font = facebookLoginButton.titleLabel?.font.withSize(17)
            
        }
        
        let facebookLoginButtonOffset = facebookLoginView.bounds.width * 0.125
        facebookLoginButton.setTitle("Login with Facebook", for: .normal)
        facebookLoginButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: facebookLoginButtonOffset, bottom: 0, right: 0)
//        facebookLoginButton.setTitleColor(UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1), for: .highlighted)
        facebookLoginButton.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .highlighted)
        
        let facebookLogoOffset = facebookLoginView.bounds.width * 0.11
        let facebookLogo = UIImageView(frame: CGRect(x: facebookLogoOffset, y: facebookLoginView.bounds.height / 2 - 27 / 2, width: 27, height: 27))
        facebookLogo.image = UIImage(named: "facebook_logo.png")
        
        facebookLoginView.addSubview(facebookLogo)
        facebookLoginView.addSubview(facebookLoginButton)
        
        self.view.addSubview(facebookLoginView)
        
        facebookLoginButton.addTarget(self, action: #selector(LoginViewController.facebookLogin), for: .touchUpInside)
        
    }
    
    func createGuestLoginButton() {
        
        let guestLoginButtonWidth = self.view.bounds.width * 0.30
        let guestLoginButtonHeight = self.view.bounds.height * 0.053
        let guestLoginButtonTopMargin = self.view.bounds.height * 0.91
        
        let guestLoginButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - guestLoginButtonWidth / 2, y: guestLoginButtonTopMargin, width: guestLoginButtonWidth, height: guestLoginButtonHeight))

        guestLoginButton.setTitle("GUEST MODE", for: .normal)
        guestLoginButton.setTitleColor(UIColor.white, for: .normal)
        guestLoginButton.setTitleColor(UIColor.white.withAlphaComponent(0.5) , for: .highlighted)
//        guestLoginButton.setTitleColor(UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1), for: .highlighted)
        
        
        if self.view.bounds.height >= 667 {
            
            guestLoginButton.titleLabel?.font = guestLoginButton.titleLabel?.font.withSize(15)
            
        } else {
            
            guestLoginButton.titleLabel?.font = guestLoginButton.titleLabel?.font.withSize(12)
            
        }
        
        self.view.addSubview(guestLoginButton)
        
        guestLoginButton.addTarget(self, action: #selector(LoginViewController.guestLogin), for: .touchUpInside)
        
        
    }

}
