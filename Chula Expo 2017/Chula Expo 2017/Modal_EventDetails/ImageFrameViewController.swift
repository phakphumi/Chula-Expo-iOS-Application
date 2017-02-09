//
//  ImageFrameViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/17/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class ImageFrameViewController: UIViewController {
    
//    var imageName: String? {
//        
//        didSet {
//            
//            imageView.image = UIImage(named: imageName!)
//            
//        }
//        
//    }

    var image: UIImage? {
        
        didSet {
            
            imageView.image = image
            
        }
        
    }
    
    let imageView: UIImageView = {
        
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        iv.contentMode = .scaleAspectFit
        
        return iv
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(imageView)
        
    }

}
