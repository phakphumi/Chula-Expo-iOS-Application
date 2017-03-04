//
//  InterestCollectionViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    var imgName: String? {
        
        didSet{
            
            if let imgName = imgName {
                
                interestImg1.image = UIImage(named: imgName)
                
            }
//            updateUI()
        }
    }
    
    var tagName: String? {
        
        didSet{
            
            if let tagName = tagName {
                
                interestName1.text = tagName
                
            }
//            updateUI()
        }
    }
    
    var tagBack: String? {
        
        didSet{
            
            if let tagBack = tagBack {
                
                backImg1.image = UIImage(named: tagBack)
                
            }
//            updateUI()
        }
    }
    
    var tagEngName: String? {
        
        didSet{
            
            if let tagEngName = tagEngName {
                
                engName1.text = tagEngName
                
            }
//            updateUI()
        }
    }
    
    var didSelectCell: Bool = false {
        
        didSet{
//            updateUI()
        }
    }
    
    @IBOutlet weak var interestView1: UIView! {
        
        didSet{
            roundedCornerBack1()
        }
    }
    
    @IBOutlet weak var backImg1: UIImageView!
    @IBOutlet weak var interestImg1: UIImageView!
    @IBOutlet weak var interestName1: UILabel!
    @IBOutlet weak var engName1: UILabel!
    
    var isAlreadyUpdateFrameSize = false
    
    var bigBackImgFrame : CGRect = CGRect()
    var bigInterestImagFrame : CGRect = CGRect()
    var bigInterestNameFrame : CGRect = CGRect()
    var bigEngnameframe : CGRect = CGRect()
    var smallBackImgFrame : CGRect = CGRect()
    var smallInterestImagFrame : CGRect = CGRect()
    var smallInterestNameFrame : CGRect = CGRect()
    var smallEngnameframe : CGRect = CGRect()

    var f = 0
    override func layoutSubviews() {
        
        super.layoutSubviews()
        roundedCornerBack1()
        backImg1.isUserInteractionEnabled = true
        interestImg1.isUserInteractionEnabled = true
      //  setupFrame()
        //interestName1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
     /// ปลยังหาวิธีเรียกให้มันได้ค่าที่ถูกต้องไม่ได้เลยย
    func setupFrame(){
        print("FM",f)
        f+=1
        bigBackImgFrame = CGRect(origin: CGPoint(x:backImg1.frame.origin.x-1, y: backImg1.frame.origin.y-1), size: CGSize(width: backImg1.bounds.size.width+1,height: backImg1.bounds.size.height+1))
        bigInterestImagFrame = CGRect(origin: CGPoint(x:interestImg1.frame.origin.x-1, y: interestImg1.frame.origin.y-1), size: CGSize(width: interestImg1.bounds.size.width+1,height: interestImg1.bounds.size.height+1))
        bigInterestNameFrame = CGRect(origin: CGPoint(x:interestName1.frame.origin.x-1, y: interestName1.frame.origin.y-1), size: CGSize(width: interestName1.bounds.size.width+1,height: interestName1.bounds.size.height+1))
        bigEngnameframe = CGRect(origin: CGPoint(x:engName1.frame.origin.x-1, y: engName1.frame.origin.y-1), size: CGSize(width: engName1.bounds.size.width+1,height: engName1.bounds.size.height+1))
        smallBackImgFrame = CGRect(origin: CGPoint(x:backImg1.frame.origin.x+1, y: backImg1.frame.origin.y+1), size: CGSize(width: backImg1.bounds.size.width-1,height: backImg1.bounds.size.height-1))
        smallInterestImagFrame = CGRect(origin: CGPoint(x:engName1.frame.origin.x+1, y: engName1.frame.origin.y+1), size: CGSize(width: engName1.bounds.size.width-1,height: engName1.bounds.size.height-1))
        smallInterestNameFrame = CGRect(origin: CGPoint(x:interestImg1.frame.origin.x+1, y: interestImg1.frame.origin.y+1), size: CGSize(width: interestImg1.bounds.size.width-1,height: interestImg1.bounds.size.height-1))
        smallEngnameframe = CGRect(origin: CGPoint(x:interestName1.frame.origin.x+1, y: interestName1.frame.origin.y+1), size: CGSize(width: interestName1.bounds.size.width-1,height: interestName1.bounds.size.height-1))
    }
    
    func updateUI(){
        
        //Reset old data
        
        interestImg1.image = nil
        interestName1.text = nil
       // backImg1.image = nil
        interestName1.isHidden = true
        
        engName1.text = nil
        engName1.isHidden = true
        //Set new data
        if let Iname1: String = imgName {
            
            interestImg1.image = UIImage(named: Iname1)
        }
     /*   if let Bname1: String = tagBack[0]
        {
            backImg1.image = UIImage(named: Bname1)
        }*/
        if let Tname1: String = tagName {
            
            if(Tname1 != ""){interestName1.isHidden = false}
            interestName1.text = Tname1
        }
        if let Ename1: String = tagEngName {
            
            if(Ename1 != ""){engName1.isHidden = false}
            engName1.text = Ename1
        }
/*        if didSelectCell {
            
            interestView1.layer.borderColor = UIColor.green.cgColor
            interestView1.layer.borderWidth = 3
            interestName1.textColor = UIColor.green
            backImg1.frame = smallBackImgFrame
            interestImg1.frame = smallInterestImagFrame
            interestName1.frame = smallInterestNameFrame
            engName1.frame = smallEngnameframe
         //   CGRect(
            
        }
        else {
            
            interestView1.layer.borderColor = UIColor.white.cgColor
            interestView1.layer.borderWidth = 0
            interestName1.textColor = UIColor.white

            
            
            backImg1.frame = bigBackImgFrame
            interestImg1.frame = bigInterestImagFrame
            interestName1.frame = bigInterestNameFrame
            engName1.frame = bigEngnameframe
            
        }*/
//        applyChangeTo(isTappedObjects: isSelected)
    }
    
    
    
    func roundedCornerBack1()
    {
        interestView1.layer.cornerRadius = 3
        interestView1.layer.masksToBounds = true
        
    }
}
