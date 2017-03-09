//
//  AboutViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/17/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import Answers

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        Answers.logContentView(withName: "About Us",
                               contentType: nil,
                               contentId: nil,
                               customAttributes: nil)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
        
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

    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
