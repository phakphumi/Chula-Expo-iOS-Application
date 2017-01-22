//
//  DescTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/16/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class DescTableViewCell: UITableViewCell {

    @IBOutlet var descText: UITextView!
    
    private static var _descTextHeight: CGFloat = 0
    
    static var descTextHeight: CGFloat {
        
        get {
            
            return self._descTextHeight
            
        }
        set(value) {
            
            self._descTextHeight = value
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
        descText.text = ""
        
    }

    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        descText.frame = CGRect(x: descText.frame.origin.x, y: descText.frame.origin.y, width: self.frame.width - descText.frame.origin.x * 2, height: 0)
//        descText.text = "A robotic vacuum cleaner, often called a robovac, is an autonomous robotic vacuum cleaner that has intelligent programming and a limited vacuum cleaning system. Some designs use spinning brushes to reach tight corners. Others combine a number of cleaning features (mopping, UV sterilization, etc.) simultaneous to vacuuming, thus rendering the machine into more than just a robot “vacuum” cleaner."
        descText.sizeToFit()

        DescTableViewCell.descTextHeight = descText.frame.height + 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
