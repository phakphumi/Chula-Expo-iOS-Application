//
//  SlideshowFrameViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/18/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class SlideshowFrameViewController: UIViewController {

    var imageName: String? {
        
        didSet {
            
            var imgUrl = ""
            
            if let url = imageName{
                
                imgUrl = "http://staff.chulaexpo.com" + url
            }
            
            imageView.imageFromServerURL(urlString: imgUrl)
        }
        
    }
    
    var topicLabelText: String? {
        
        didSet {
            
            topicLabel.text = topicLabelText
        }
    }
    
    var descLabelText: String? {
        
        didSet {
            
            descLabel.text = descLabelText
        }
    }
    
    let imageView: UIImageView = {
        
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 220))
        iv.contentMode = .scaleAspectFit
        
        return iv
        
    }()
    
    let topicLabel: UILabel = {
        
        let tl = UILabel(frame: CGRect(x: 15, y: 22, width: 375 - 15, height: 26))
        
        
        tl.font = UIFont(name: "SukhumvitSet-Medium", size: 20)
//        tl.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightSemibold)
        tl.textColor = UIColor.white
        tl.layer.shadowOffset = CGSize(width: 0, height: 0)
        tl.layer.shadowOpacity = 0.15
        tl.layer.shadowRadius = 2
        
        return tl
        
    }()
    
    let descLabel: UILabel = {
        
        let dl = UILabel(frame: CGRect(x: 15, y: 50, width: 375 - 15, height: 16))
        dl.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        dl.textColor = UIColor.white
        
        return dl
        
    }()
    
//    var slideshowTopic = ["Welcome to Chula Expo 2017", "Chula Expo Special Event"]
//    var slideshowDesc = ["9:41-10:41 • Main auditorium Building 3", "13:00-14:00 • Main auditorium"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(imageView)
        
        createTextView()
        
    }
    
    func createTextView() {
        
        let slideshowView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 220))
        
        createGradientLayer(gradientView: slideshowView)
        
        let labelView = UIView(frame: CGRect(x: 0, y: 137, width: UIScreen.main.bounds.width, height: 83))
        labelView.layer.zPosition = 2
        
        let highlightLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 85 , height: 20))
        highlightLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        highlightLabel.text = "HIGHLIGHT"
        highlightLabel.textColor = UIColor.white
        highlightLabel.backgroundColor = UIColor(red:1.00, green:0.42, blue:0.60, alpha:0.7)
        highlightLabel.textAlignment = NSTextAlignment.center
        highlightLabel.layer.cornerRadius = highlightLabel.bounds.height / 2
        highlightLabel.layer.masksToBounds = true
        
        labelView.addSubview(highlightLabel)
        
        labelView.addSubview(topicLabel)
        
        labelView.addSubview(descLabel)
        
        slideshowView.addSubview(labelView)
        
        self.view.addSubview(slideshowView)
        
    }
    
    func createGradientLayer(gradientView: UIView) {
        
        //Begin, define gradient layer scale
        let gradientWidth = 375
        let gradientHeight = 220
        //End, define
        
        //Begin, define gradient color shade from RGB(108,85,185) to RGB(202,92,171)
        let headGradientColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        let tailGradientColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientWidth, height: gradientHeight)
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        //End
        
        gradientLayer.zPosition = 1
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
    }

}
