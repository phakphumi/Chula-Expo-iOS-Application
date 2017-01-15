//
//  TopicImageController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class TopicImageController: UINavigationBar {
    
    override func awakeFromNib() {

        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        print(self.bounds.height)
        print(self.bounds.width)
        
        self.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: (self.superview?.bounds.height)! * 0.4)
        
        let topicImage = UIImageView(frame: self.frame)
        topicImage.image = #imageLiteral(resourceName: "event_detail_temp")
        topicImage.contentMode = .scaleAspectFill
        
        self.addSubview(topicImage)
        
    }

}
