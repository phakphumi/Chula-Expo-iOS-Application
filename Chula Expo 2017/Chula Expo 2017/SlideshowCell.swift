//
//  SlideshowCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class SlideshowCell: UITableViewCell {
    
    var slideshowView = UIView()
    var slideshowImage = [UIImage(named: "chula_expo_logo.png"), UIImage(named: "medical.png")]
    var slideshowImageView = [UIImageView]()
    var timer = Timer()
    var slideTagCounter = 1
    
    
    let slideshowTag = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        slideshowView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        slideshowView.tag = slideshowTag
        
        for i in 0..<slideshowImage.count {
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slideshowView.bounds.width, height: slideshowView.bounds.height))

            imageView.image = slideshowImage[i]
            imageView.tag = i+1
            if i == 0 {
                
                imageView.alpha = 1
                
            } else {
                
                imageView.alpha = 0
                
            }
            
            slideshowImageView.append(imageView)
            
            slideshowView.addSubview(imageView)
            
        }
        
        self.addSubview(slideshowView)
        
        slideshowView = self.viewWithTag(slideshowTag)!
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(SlideshowCell.autoSliding), userInfo: nil, repeats: true)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func autoSliding() {
        
        if slideTagCounter + 1 <= slideshowImage.count {
            
            let current = slideshowView.viewWithTag(slideTagCounter)
            let next = slideshowView.viewWithTag(slideTagCounter + 1)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                current?.alpha = 0
                next?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter += 1
                    
                }
                
            })
            
        } else {
            
            let current = slideshowView.viewWithTag(slideTagCounter)
            let next = slideshowView.viewWithTag(1)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                current?.alpha = 0
                next?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter = 1
                    
                }
                
            })
            
        }
        
    }

}
