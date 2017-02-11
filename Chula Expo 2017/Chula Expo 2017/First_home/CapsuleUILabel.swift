//
//  CapsuleUILabel.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/17/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class CapsuleUILabel: UILabel {

    let topInset = CGFloat(0)
    let bottomInset = CGFloat(0)
    let leftInset = CGFloat(2.5)
    let rightInset = CGFloat(2.5)
    
    override func drawText(in rect: CGRect)
    {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize
    {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    func makeRound() {
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    func setText(name: String){
        
        text = name
        switch name {
        case "วิศวะ":
            backgroundColor = UIColor(red: 0.61, green: 0.00, blue: 0.01, alpha: 1)
        case "อักษร":
            backgroundColor = UIColor(red:0.52, green:0.51, blue:0.52, alpha:1.0)
        case "นิเทศ":
            backgroundColor = UIColor(red: 0.61, green: 0.00, blue: 0.01, alpha: 1)
        
        
        default:
            
            backgroundColor = UIColor.gray
        }
        
        self.layer.cornerRadius = CGFloat(3)
        self.layer.masksToBounds = true

    }
}
