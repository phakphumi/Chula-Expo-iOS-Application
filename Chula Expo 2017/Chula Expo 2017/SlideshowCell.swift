//
//  SlideshowCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class SlideshowCell: UITableViewCell{
    
    var slideshowView = UIView()
    var slideshowImage = [UIImage(named: "chula_expo_logo.png"), UIImage(named: "medical.png")]
    var slideshowTopic = ["Chula Expo Special Event", "Medicine Special Event"]
    var slideshowDesc = ["9:41-10:41 Main auditorium Building 3", "13:00-14:00 Chula Hospital"]
    var timer = Timer()
    var slideTagCounter = 0
    
    let tagName: [String] = ["ENG", "MED"]
    let tagController = TagController()
    let slideshowTag = 10
    let labelViewTag = 50
    let baseSlideshowImageTag = 100
    let baseSlideshowTopicTag = 150
    let baseSlideshowTagTag = 200
    let baseSlideshowDescTag = 250
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        createSlideshow()
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(SlideshowCell.autoSliding), userInfo: nil, repeats: true)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createTopicLabel(text: String) -> UILabel {
        
        let topicLabel = UILabel(frame: CGRect(x: 8, y: 14, width: 270, height: 24))
        topicLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold)
        topicLabel.textColor = UIColor.white
        topicLabel.text = text

        return topicLabel
        
    }
    
    func createDescLabel(text: String) -> UILabel {
        
        let descLabel = UILabel(frame: CGRect(x: 51, y: 41, width: 330, height: 20))
        descLabel.font = UIFont.systemFont(ofSize: 13)
        descLabel.textColor = UIColor.white
        descLabel.text = text
        
        return descLabel
        
    }
    
    func createSlideshow() {
        
        slideshowView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        slideshowView.tag = slideshowTag
        
        let labelView = UIView(frame: CGRect(x: 0, y: 175, width: self.bounds.width, height: 75))
        labelView.tag = labelViewTag
        labelView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        labelView.layer.zPosition = 1
        
        let highlightLabel = UILabel(frame: CGRect(x: 285, y: 4, width: 85 , height: 20))
        highlightLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        highlightLabel.textColor = UIColor.white
        highlightLabel.text = "HIGHLIGHT"
        
        for i in 0..<slideshowImage.count {
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slideshowView.bounds.width, height: slideshowView.bounds.height))
            imageView.image = slideshowImage[i]
            imageView.tag = baseSlideshowImageTag + i
            
            let topicLabel = createTopicLabel(text: slideshowTopic[i])
            topicLabel.tag = baseSlideshowTopicTag + i
            
            let tagLabel = tagController.createTagLabel(x: 6, y: 41, tagName: tagName[i])
            tagLabel.tag = baseSlideshowTagTag + i
            
            let descLabel = createDescLabel(text: slideshowDesc[i])
            descLabel.tag = baseSlideshowDescTag + i
            
            if i != 0 {
                
                imageView.alpha = 0
                
                topicLabel.alpha = 0
                
                tagLabel.alpha = 0
                
                descLabel.alpha = 0
                
            }
            
            labelView.addSubview(topicLabel)
            
            labelView.addSubview(tagLabel)
            
            labelView.addSubview(descLabel)
            
            slideshowView.addSubview(imageView)
            
        }
        
        labelView.addSubview(highlightLabel)
        
        slideshowView.addSubview(labelView)
        
        self.addSubview(slideshowView)
        
        slideshowView = self.viewWithTag(slideshowTag)! // get item to control slideshowView

        
    }
    
    func autoSliding() {
        
        let labelView = slideshowView.viewWithTag(labelViewTag)
        
        if slideTagCounter + 1 < slideshowImage.count {
            
            let currentImage = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter)
            let nextImage = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter + 1)
            
            let currentTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter)
            let nextTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter + 1)
            
            let currentTag = labelView?.viewWithTag(baseSlideshowTagTag + slideTagCounter)
            let nextTag = labelView?.viewWithTag(baseSlideshowTagTag + slideTagCounter + 1)
            
            let currentDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter)
            let nextDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter + 1)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                currentImage?.alpha = 0
                nextImage?.alpha = 1
                
                currentTopic?.alpha = 0
                nextTopic?.alpha = 1
                
                currentTag?.alpha = 0
                nextTag?.alpha = 1
                
                currentDesc?.alpha = 0
                nextDesc?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter += 1
                    
                }
                
            })
            
        } else {
            
            let current = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter)
            let next = slideshowView.viewWithTag(baseSlideshowImageTag)
            
            let currentTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter)
            let nextTopic = labelView?.viewWithTag(baseSlideshowTopicTag)
            
            let currentTag = labelView?.viewWithTag(baseSlideshowTagTag + slideTagCounter)
            let nextTag = labelView?.viewWithTag(baseSlideshowTagTag)
            
            let currentDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter)
            let nextDesc = labelView?.viewWithTag(baseSlideshowDescTag)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                current?.alpha = 0
                next?.alpha = 1
                
                currentTopic?.alpha = 0
                nextTopic?.alpha = 1
                
                currentTag?.alpha = 0
                nextTag?.alpha = 1
                
                currentDesc?.alpha = 0
                nextDesc?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter = 0
                    
                }
                
            })
            
        }
        
    }

}
