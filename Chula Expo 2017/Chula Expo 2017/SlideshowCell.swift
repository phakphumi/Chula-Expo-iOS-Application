//
//  SlideshowCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class SlideshowCell: UITableViewCell{
    
    var numberOfSlideshow: Int!
    var slideshowView: UIView!
    var pageControl: UIPageControl!
    var slideshowImage = [UIImage(named: "chula_expo_logo.png"), UIImage(named: "medical.png")]
    var slideshowTopic = ["Chula Expo Special Event", "Medicine Special Event"]
    var slideshowDesc = ["9:41-10:41 • Main auditorium Building 3", "13:00-14:00 • Chula Hospital"]
    var timer = Timer()
    var slideTagCounter = 0
    
    let slideshowTag = 10
    let labelViewTag = 50
    let baseSlideshowImageTag = 100
    let baseSlideshowTopicTag = 150
    let baseSlideshowDescTag = 200
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        numberOfSlideshow = slideshowImage.count
        
        createSlideshow()
        
        startAutoSliding()
        
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        swipeGestureLeft.addTarget(self, action: #selector(SlideshowCell.swipeLeft))
        swipeGestureRight.addTarget(self, action: #selector(SlideshowCell.swipeRight))
        
        self.addGestureRecognizer(swipeGestureLeft)
        self.addGestureRecognizer(swipeGestureRight)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func swipeLeft() {
        
        resetAutoSliding()
        
        nextSlide()
        
        startAutoSliding()
        
    }
    
    func swipeRight() {
        
        resetAutoSliding()
        
        prevSlide()
        
        startAutoSliding()
        
    }
    
    func startAutoSliding() {
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(SlideshowCell.nextSlide), userInfo: nil, repeats: true)
        
    }
    
    func resetAutoSliding() {
        
        timer.invalidate()
        
    }
    
    func createTopicLabel(text: String) -> UILabel {
        
        let topicLabel = UILabel(frame: CGRect(x: 15, y: 22, width: self.bounds.width - 15, height: 26))
        topicLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightSemibold)
        topicLabel.textColor = UIColor.white
        topicLabel.text = text
        topicLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        topicLabel.layer.shadowOpacity = 0.15
        topicLabel.layer.shadowRadius = 2

        return topicLabel
        
    }
    
    func createDescLabel(text: String) -> UILabel {
        
        let descLabel = UILabel(frame: CGRect(x: 15, y: 50, width: self.bounds.width - 15, height: 16))
        descLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        descLabel.textColor = UIColor.white
        descLabel.text = text
        
        return descLabel
        
    }
    
    func createSlideshow() {
        
        slideshowView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        slideshowView.tag = slideshowTag
        
        createGradientLayer(gradientView: slideshowView)
        
        let labelView = UIView(frame: CGRect(x: 0, y: 137, width: self.bounds.width, height: 83))
        labelView.tag = labelViewTag
        labelView.layer.zPosition = 2
        
        
        let highlightLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 85 , height: 20))
        highlightLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        highlightLabel.text = "HIGHLIGHT"
        highlightLabel.textColor = UIColor.white
        highlightLabel.backgroundColor = UIColor(red: 0.796, green: 0.341, blue: 0.678, alpha: 1)
        highlightLabel.textAlignment = NSTextAlignment.center
        highlightLabel.layer.cornerRadius = highlightLabel.bounds.height / 2
        highlightLabel.layer.masksToBounds = true
        
        pageControl = UIPageControl(frame: CGRect(x: labelView.bounds.width / 2 - 100, y: 72, width: 200, height: 6))
        pageControl.numberOfPages = numberOfSlideshow
        
        for i in 0..<slideshowImage.count {
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slideshowView.bounds.width, height: slideshowView.bounds.height))
            imageView.image = slideshowImage[i]
            imageView.tag = baseSlideshowImageTag + i
            
            let topicLabel = createTopicLabel(text: slideshowTopic[i])
            topicLabel.tag = baseSlideshowTopicTag + i
            
            let descLabel = createDescLabel(text: slideshowDesc[i])
            descLabel.tag = baseSlideshowDescTag + i
            
            if i != 0 {
                
                imageView.alpha = 0
                
                topicLabel.alpha = 0
                
                descLabel.alpha = 0
                
            }
            
            labelView.addSubview(topicLabel)
            
            labelView.addSubview(descLabel)
            
            slideshowView.addSubview(imageView)
            
        }
        
        labelView.addSubview(highlightLabel)
        
        labelView.addSubview(pageControl)
        
        slideshowView.addSubview(labelView)
        
        self.addSubview(slideshowView)
        
        slideshowView = self.viewWithTag(slideshowTag)! // get item to control slideshowView

        
    }
    
    func nextSlide() {
        
        let labelView = slideshowView.viewWithTag(labelViewTag)
        
        if slideTagCounter + 1 < slideshowImage.count {
            
            let nextPageNumber = slideTagCounter + 1
            
            let currentImage = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter)
            let nextImage = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter + 1)
            
            let currentTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter)
            let nextTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter + 1)
            
            let currentDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter)
            let nextDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter + 1)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.pageControl.currentPage = nextPageNumber
                
                currentImage?.alpha = 0
                nextImage?.alpha = 1
                
                currentTopic?.alpha = 0
                nextTopic?.alpha = 1
                
                currentDesc?.alpha = 0
                nextDesc?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter += 1
                    
                }
                
            })
            
        } else {
            
            let nextPageNumber = 0
            
            let current = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter)
            let next = slideshowView.viewWithTag(baseSlideshowImageTag)
            
            let currentTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter)
            let nextTopic = labelView?.viewWithTag(baseSlideshowTopicTag)
            
            let currentDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter)
            let nextDesc = labelView?.viewWithTag(baseSlideshowDescTag)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.pageControl.currentPage = nextPageNumber
                
                current?.alpha = 0
                next?.alpha = 1
                
                currentTopic?.alpha = 0
                nextTopic?.alpha = 1
                
                currentDesc?.alpha = 0
                nextDesc?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter = 0
                    
                }
                
            })
            
        }
        
    }
    
    func prevSlide() {
        
        let labelView = slideshowView.viewWithTag(labelViewTag)
        
        if slideTagCounter - 1 >= 0 {
            
            let prevPageNumber = slideTagCounter - 1
            
            let currentImage = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter)
            let prevImage = slideshowView.viewWithTag(baseSlideshowImageTag + slideTagCounter - 1)
            
            let currentTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter)
            let prevTopic = labelView?.viewWithTag(baseSlideshowTopicTag + slideTagCounter - 1)
            
            let currentDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter)
            let prevDesc = labelView?.viewWithTag(baseSlideshowDescTag + slideTagCounter - 1)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.pageControl.currentPage = prevPageNumber
                
                currentImage?.alpha = 0
                prevImage?.alpha = 1
                
                currentTopic?.alpha = 0
                prevTopic?.alpha = 1
                
                currentDesc?.alpha = 0
                prevDesc?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter -= 1
                    
                }
                
            })
            
        } else {
            
            let lastSlidePageNumber = slideshowImage.count - 1
            
            let currentImage = slideshowView.viewWithTag(baseSlideshowImageTag)
            let prevImage = slideshowView.viewWithTag(baseSlideshowImageTag + lastSlidePageNumber)
            
            let currentTopic = labelView?.viewWithTag(baseSlideshowTopicTag )
            let prevTopic = labelView?.viewWithTag(baseSlideshowTopicTag + lastSlidePageNumber)
            
            let currentDesc = labelView?.viewWithTag(baseSlideshowDescTag)
            let prevDesc = labelView?.viewWithTag(baseSlideshowDescTag + lastSlidePageNumber)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.pageControl.currentPage = lastSlidePageNumber
                
                currentImage?.alpha = 0
                prevImage?.alpha = 1
                
                currentTopic?.alpha = 0
                prevTopic?.alpha = 1
                
                currentDesc?.alpha = 0
                prevDesc?.alpha = 1
                
            }, completion: { (success) in
                
                if success {
                    
                    self.slideTagCounter = lastSlidePageNumber
                    
                }
                
            })
            
        }
        
    }
    
    func createGradientLayer(gradientView: UIView) {
        
        //Begin, define gradient layer scale
        let gradientWidth = self.bounds.width
        let gradientHeight = self.bounds.height
        //End, define
        
        //Begin, define gradient color shade from RGB(108,85,185) to RGB(202,92,171)
        let headGradientColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        let tailGradientColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
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
