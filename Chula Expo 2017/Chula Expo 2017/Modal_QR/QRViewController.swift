//
//  QRViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/11/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit

class QRViewController: UIViewController {
    
    @IBOutlet var qrView: UIView!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var qrCodeImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var schoolOrCompany: UILabel!
    
    @IBAction func cancle(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    var baseQRViewCenter = CGPoint()
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //load auto layout
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        baseQRViewCenter = qrView.center
        
        fetchUserData()
        
        createGradientLayer()
        
        stylingProfileImage()
        
        addDragGestureToCancel()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func fetchUserData() {
        
        managedObjectContext?.perform {
            
            let userData = UserData.fetchUser(id: UserController.userId!, inManageobjectcontext: self.managedObjectContext!)!
            
            self.setImageProfile(pictureUrl: userData.profile!)
            self.name.text = userData.name
            
            if userData.type == "student" {
                
                self.schoolOrCompany.text = userData.school
                
            } else {
                
                self.schoolOrCompany.text = userData.job
                
            }
            
            let qrImage = self.generateQRCode(from: "\(userData.name!)")
            
            self.qrCodeImage.image = qrImage
            
        }
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    
    func setImageProfile(pictureUrl: String) {
        
        let facebookProfileUrl = URL(string: pictureUrl)
        
        if let data = NSData(contentsOf: facebookProfileUrl!) {
            
            self.profileImage.image = UIImage(data: data as Data)
            
        }
        
    }
    
    func drag(gestureRecognizer: UIPanGestureRecognizer) {
        
        let xDistanceToDismiss = self.view.bounds.width * 0.3
        let yDistanceToDismiss = self.view.bounds.height * 0.3
        
        let translation = gestureRecognizer.translation(in: view)
        
        let touchedMovingView = gestureRecognizer.view! // get moving object
        
        touchedMovingView.center = CGPoint(x: baseQRViewCenter.x + translation.x, y: baseQRViewCenter.y + translation.y)
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            let xFromCenter = abs(touchedMovingView.center.x - self.view.bounds.width / 2) // check how far from center
            let yFromCenter = abs(touchedMovingView.center.y - self.view.bounds.height / 2)
            
            if xFromCenter > xDistanceToDismiss || yFromCenter > yDistanceToDismiss {
                
                self.dismiss(animated: true, completion: nil)
                
            } else {
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    touchedMovingView.center = self.baseQRViewCenter
                    
                })
                
            }
            
        }
        
    }
    
    func addDragGestureToCancel() {
        
        let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(QRViewController.drag(gestureRecognizer:)))
        qrView.addGestureRecognizer(dragGestureRecognizer)
        
    }
    
    func stylingProfileImage() {
        
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 3
        profileImage.layer.masksToBounds = true
        
    }
    
    func createGradientLayer() {
        
        //Begin, define gradient color shade from RGB(210,116,184) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.82, green: 0.455, blue: 0.72, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.565, green: 0.44, blue: 0.77, alpha: 1).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientView.bounds.width, height: gradientView.bounds.height)
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        //End
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
    }

}
