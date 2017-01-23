//
//  RelatedTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/16/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class RelatedTableViewCell: UITableViewCell {

    @IBOutlet var relatedText: UITextView!
    
    private static var _relatedTextHeight: CGFloat = 0
    
    static var relatedTextHeight: CGFloat {
        
        get {
            
            return self._relatedTextHeight
            
        }
        set(value) {
            
            self._relatedTextHeight = value
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()

        relatedText.frame = CGRect(x: relatedText.frame.origin.x, y: relatedText.frame.origin.y, width: self.frame.width - relatedText.frame.origin.x * 2, height: 0)
//        relatedText.text = "Technology • Smart home • Robot • IOT • Algorithm • Computer • Cleaner • Future"
        relatedText.sizeToFit()
        RelatedTableViewCell.relatedTextHeight = relatedText.frame.height + 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
