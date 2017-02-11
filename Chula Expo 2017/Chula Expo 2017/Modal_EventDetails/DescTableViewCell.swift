//
//  DescTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/16/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class DescTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
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
    
    static var descCellHeight: CGFloat {
        
        get {
            
            return self._descTextHeight + 10
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
        //descText.text = ""
        
    }

    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        descText.font = UIFont(name: "Sukhumvit Set", size: 14)
        descText.frame = CGRect(x: descText.frame.origin.x, y: descText.frame.origin.y, width: bgView.bounds.width - 16, height: 0)
//        descText.text = "A robotic vacuum cleaner, often called a robovac, is an autonomous robotic vacuum cleaner that has intelligent programming and a limited vacuum cleaning system. Some designs use spinning brushes to reach tight corners. Others combine a number of cleaning features (mopping, UV sterilization, etc.) simultaneous to vacuuming, thus rendering the machine into more than just a robot “vacuum” cleaner."
        descText.sizeToFit()

        DescTableViewCell.descTextHeight = descText.frame.height
        
        bgView.frame = CGRect(x: bgView.frame.origin.x, y: bgView.frame.origin.y, width: bgView.bounds.width, height: descText.bounds.height + 16)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
