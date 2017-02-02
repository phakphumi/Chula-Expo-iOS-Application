////
////  TagController.swift
////  Chula Expo 2017
////
////  Created by Pakpoom on 1/9/2560 BE.
////  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
////
//
//import UIKit
//
//class TagController {
//
//    let tagColor: [String: UIColor] = ["ENG": UIColor(red: 0.467, green: 0.188, blue: 0.141, alpha: 1),
//                                       "MED": UIColor(red: 0, green: 0, blue: 0.545, alpha: 1)]
//    
//    func createTagLabel(x: Int, y: Int, tagName: String) -> UILabel {
//        
//        let tagLabel = UILabel(frame: CGRect(x: x, y: y, width: 40, height: 20))
//        tagLabel.text = tagName
//        tagLabel.textColor = UIColor.white
//        tagLabel.font = UIFont.systemFont(ofSize: 11)
//        tagLabel.backgroundColor = tagColor[tagName]
//        tagLabel.textAlignment = NSTextAlignment.center
//        tagLabel.layer.cornerRadius = tagLabel.bounds.height / 2
//        tagLabel.layer.masksToBounds = true
//        
//        return tagLabel
//        
//    }
//
//}
