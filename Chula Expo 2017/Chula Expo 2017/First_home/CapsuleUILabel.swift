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
//    func makeRound() {
//        self.layer.cornerRadius = 2
//        self.clipsToBounds = true
//        self.layer.masksToBounds = false
//    }
    func setText(name: String){
        
        self.textColor = UIColor.white
        text = name
        switch name {
        
        case "SMART":
            backgroundColor = UIColor(red:0.96, green:0.54, blue:0.29, alpha:1.0)
        case "HEALTH":
            backgroundColor = UIColor(red:0.44, green:0.76, blue:0.63, alpha:1.0)
        case "HUMAN":
            backgroundColor = UIColor(red:0.22, green:0.15, blue:0.38, alpha:1.0)
        case "ENG":
            backgroundColor = UIColor(red:0.50, green:0.00, blue:0.00, alpha:1.0)
        case "ARTS":
            backgroundColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
        case "SCI":
            backgroundColor = UIColor(red:1.00, green:1.00, blue:0.00, alpha:1.0)
            self.textColor = UIColor.black
        case "POLISC":
            backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
        case "ARCH":
            backgroundColor = UIColor(red:0.60, green:0.20, blue:0.00, alpha:1.0)
        case "BANSHI":
            backgroundColor = UIColor(red:0.00, green:0.80, blue:1.00, alpha:1.0)
        case "EDU":
            backgroundColor = UIColor(red:1.00, green:0.20, blue:0.00, alpha:1.0)
        case "COMMARTS":
            backgroundColor = UIColor(red:0.00, green:0.00, blue:0.50, alpha:1.0)
        case "ECON":
            backgroundColor = UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0)
            self.textColor = UIColor.black
        case "MED":
            backgroundColor = UIColor(red:0.02, green:0.38, blue:0.01, alpha:1.0)
        case "VET":
            backgroundColor = UIColor(red:0.40, green:0.80, blue:0.80, alpha:1.0)
        case "DENT":
            backgroundColor = UIColor(red:0.20, green:0.00, blue:0.60, alpha:1.0)
        case "PHARM":
            backgroundColor = UIColor(red:0.40, green:0.80, blue:0.20, alpha:1.0)
        case "LAW":
            backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
            self.textColor = UIColor.black
        case "FAA":
            backgroundColor = UIColor(red:0.80, green:0.00, blue:0.00, alpha:1.0)
        case "NUR":
            backgroundColor = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
        case "AHS":
            backgroundColor = UIColor(red:0.80, green:0.60, blue:1.00, alpha:1.0)
            self.textColor = UIColor.black
        case "PSY":
            backgroundColor = UIColor(red:0.20, green:0.00, blue:1.00, alpha:1.0)
        case "SPSC":
            backgroundColor = UIColor(red:1.00, green:0.40, blue:0.00, alpha:1.0)
        case "SAR":
            backgroundColor = UIColor(red:0.60, green:0.11, blue:0.11, alpha:1.0)
        case "GRAD":
            backgroundColor = UIColor(red:0.75, green:0.38, blue:0.50, alpha:1.0)        
        default:
            
            backgroundColor = UIColor.gray
        }
        
        self.layer.cornerRadius = CGFloat(3)
        self.layer.masksToBounds = true

    }
}
