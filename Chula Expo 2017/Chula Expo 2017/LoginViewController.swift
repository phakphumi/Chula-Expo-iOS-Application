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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var token = ""
    var name = ""
    var email = ""
    var fbImageProfileUrl = ""
    var imageProfile: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        if FBSDKAccessToken.current() != nil {
            
            let managedObjectContext: NSManagedObjectContext? =
                (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
            
            var userData: UserData!
            
            managedObjectContext?.perform {

                userData = UserData.fetchUser(token: FBSDKAccessToken.current().tokenString, inManageobjectcontext: managedObjectContext!)
                
            }
            
            if userData != nil {
                    
                self.performSegue(withIdentifier: "toTabBarController", sender: self)
                    
            } else {
                    
                self.profileUpdate()
                
            }
            
        } else {
        
            createGradientLayer()
        
            createLogo()
        
            createFacebookLoginButton()
        
            createGuestLoginButton()
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRegister" {
            
            let navigationController = segue.destination as! UINavigationController
            
            let registerViewController = navigationController.viewControllers.first as! RegisterViewController
            
            registerViewController.token = self.token
            registerViewController.name = self.name
            registerViewController.email = self.email
            registerViewController.fbImageProfileUrl = self.fbImageProfileUrl
            registerViewController.imageProfile = self.imageProfile
            
        }
        
    }
    
    func profileUpdate() {
        
        if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]) {
            
            graphRequest.start(completionHandler: { (connection, result, error) in
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let userDetails = result as? [String: String] {
                        
                        let userID = userDetails["id"]!
                        
                        self.token = FBSDKAccessToken.current().tokenString
                        
                        self.name = userDetails["name"]!
                        
                        self.email = userDetails["email"]!
                        
                        self.fbImageProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
                        
                        self.setImageProfile(userID: userID)
                        
                        self.performSegue(withIdentifier: "toRegister", sender: self)
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    func guestLogin() {
        
        self.name = "Yourname Lastname"
        self.imageProfile = UIImage(named: "chula_expo_logo.jpg")
        
        performSegue(withIdentifier: "toRegister", sender: self)
        
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
                    
                    self.profileUpdate()
                    
                }
                
            }
            
        }

    }
    
    func setImageProfile(userID: String) {
        
        let facebookProfileUrl = URL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
        
        if let data = NSData(contentsOf: facebookProfileUrl!) {
            
            self.imageProfile = UIImage(data: data as Data)
            
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createFacebookLoginButton() {
        
        let facebookLoginViewWidth = self.view.bounds.width * 0.8
        let facebookLoginViewHeight = self.view.bounds.height * 0.093
        let facebookLoginViewTopMargin = self.view.bounds.height * 0.75
        
        let facebookLoginView = UIView(frame: CGRect(x: self.view.bounds.width / 2 - facebookLoginViewWidth / 2, y: facebookLoginViewTopMargin, width: facebookLoginViewWidth, height: facebookLoginViewHeight))
        facebookLoginView.layer.cornerRadius = facebookLoginViewHeight / 2
        facebookLoginView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        
        let facebookLoginButton = UIButton(frame: CGRect(x: 0, y: 0, width: facebookLoginViewWidth, height: facebookLoginViewHeight))
        
        if self.view.bounds.height >= 667 {
            
            facebookLoginButton.titleLabel?.font = facebookLoginButton.titleLabel?.font.withSize(20)
            
        } else {
            
            facebookLoginButton.titleLabel?.font = facebookLoginButton.titleLabel?.font.withSize(17)
            
        }
        
        let facebookLoginButtonOffset = facebookLoginView.bounds.width * 0.125
        facebookLoginButton.setTitle("Log In With Facebook", for: .normal)
        facebookLoginButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: facebookLoginButtonOffset, bottom: 0, right: 0)
        facebookLoginButton.setTitleColor(UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1), for: .highlighted)
        
        let facebookLogoOffset = facebookLoginView.bounds.width * 0.11
        let facebookLogo = UIImageView(frame: CGRect(x: facebookLogoOffset, y: facebookLoginView.bounds.height / 2 - 27 / 2, width: 27, height: 27))
        facebookLogo.image = UIImage(named: "facebook_logo.png")
        
        facebookLoginView.addSubview(facebookLogo)
        facebookLoginView.addSubview(facebookLoginButton)
        
        self.view.addSubview(facebookLoginView)
        
        facebookLoginButton.addTarget(self, action: #selector(LoginViewController.facebookLogin), for: .touchUpInside)
        
    }
    
    func createGuestLoginButton() {
        
        let guestLoginButtonWidth = self.view.bounds.width * 0.24
        let guestLoginButtonHeight = self.view.bounds.height * 0.053
        let guestLoginButtonTopMargin = self.view.bounds.height * 0.86
        
        let guestLoginButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - guestLoginButtonWidth / 2, y: guestLoginButtonTopMargin, width: guestLoginButtonWidth, height: guestLoginButtonHeight))

        guestLoginButton.setTitle("Guest Mode", for: .normal)
        guestLoginButton.setTitleColor(UIColor(red: 0.31, green: 0.184, blue: 0.5725, alpha: 1), for: .normal)
        guestLoginButton.setTitleColor(UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1), for: .highlighted)
        
        if self.view.bounds.height >= 667 {
            
            guestLoginButton.titleLabel?.font = guestLoginButton.titleLabel?.font.withSize(15)
            
        } else {
            
            guestLoginButton.titleLabel?.font = guestLoginButton.titleLabel?.font.withSize(12)
            
        }
        
        self.view.addSubview(guestLoginButton)
        
        guestLoginButton.addTarget(self, action: #selector(LoginViewController.guestLogin), for: .touchUpInside)
        
        
    }
    
    func createLogo() {
        
        let imageViewWidth = self.view.bounds.width * 0.613
        let imageViewHeight = self.view.bounds.height * 0.45
        let imageViewTopMargin = self.view.bounds.height * 0.15
        
        let logoImageView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - imageViewWidth / 2, y: imageViewTopMargin, width: imageViewWidth, height: imageViewHeight))
        logoImageView.image = UIImage(named: "chula_expo_logo_white.png")
        logoImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        self.view.addSubview(logoImageView)
    }
    
    func createGradientLayer() {
        
        //Begin, define gradient layer scale
        let gradientWidth = self.view.bounds.width
        let gradientHeight = self.view.bounds.height
        //End, define
        
        //Begin, define gradient color shade from RGB(108,85,185) to RGB(202,92,171)
        let headGradientColor = UIColor(red: 0.4235, green: 0.33, blue: 0.725, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.79, green: 0.36, blue: 0.67, alpha: 1).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientWidth, height: gradientHeight)
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        //End
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }

}
