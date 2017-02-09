//
//  MeViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/9/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!

    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var editfacView: UIView!
    @IBOutlet weak var edittagView: UIView!
    @IBOutlet weak var reserveView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var proView: UIView!
    @IBOutlet weak var editproButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.borderColor = UIColor(red: 0.1725, green: 0.1922, blue: 0.2471, alpha: 1).cgColor
        profileImg.layer.borderWidth = 3
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.masksToBounds = true
        
        editproButton.layer.cornerRadius = 3
        editproButton.layer.masksToBounds = true
        aboutView.layer.cornerRadius = 3
        aboutView.layer.masksToBounds = true
        faqView.layer.cornerRadius = 3
        faqView.layer.masksToBounds = true
        editfacView.layer.cornerRadius = 3
        editfacView.layer.masksToBounds = true
        edittagView.layer.cornerRadius = 3
        edittagView.layer.masksToBounds = true
        eventView.layer.cornerRadius = 3
        eventView.layer.masksToBounds = true
        reserveView.layer.cornerRadius = 3
        reserveView.layer.masksToBounds = true
        reserveView.layer.cornerRadius = 3
        reserveView.layer.masksToBounds = true

        logoutView.layer.cornerRadius = 5
        logoutView.layer.masksToBounds = true

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
