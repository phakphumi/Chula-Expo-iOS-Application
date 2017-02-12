//
//  InterestCollectionViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/23/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    var imgName: [String?] = ["","",""]
        {
        didSet{
            updateUI()
        }
    }
    
    var tagName: [String?] = ["","",""]
        {
        didSet{
            updateUI()
        }
    }
    
    var tagBack: [String?] = ["","",""]
        {
        didSet{
            updateUI()
        }
    }
    
    var tagEngName: [String?] = ["","",""]
        {
        didSet{
            updateUI()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedCornerBack1()
        
        backImg1.isUserInteractionEnabled = true
        interestImg1.isUserInteractionEnabled = true
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(InterestCollectionViewCell.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        
        backImg1.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(InterestCollectionViewCell.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer2.numberOfTapsRequired = 1
        
        interestImg1.addGestureRecognizer(tapGestureRecognizer2)
        

        //interestName1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    var isTappedObjects: [Bool] = [false,false,false]
    func wasTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        print("tap")
        if interestName1.text != nil {
            if isTappedObjects[0] == true{
                isTappedObjects[0] = false;
                //interestName1.font = UIFont(name: interestName1.font.fontName, size: 14)
                backImg1.frame = CGRect(origin: CGPoint(x:backImg1.frame.origin.x-1, y: backImg1.frame.origin.y-1), size: CGSize(width: backImg1.bounds.size.width+1,height: backImg1.bounds.size.height+1))
                interestImg1.frame = CGRect(origin: CGPoint(x:interestImg1.frame.origin.x-1, y: interestImg1.frame.origin.y-1), size: CGSize(width: interestImg1.bounds.size.width+1,height: interestImg1.bounds.size.height+1))
                interestName1.frame = CGRect(origin: CGPoint(x:interestName1.frame.origin.x-1, y: interestName1.frame.origin.y-1), size: CGSize(width: interestName1.bounds.size.width+1,height: interestName1.bounds.size.height+1))
                engName1.frame = CGRect(origin: CGPoint(x:engName1.frame.origin.x-1, y: engName1.frame.origin.y-1), size: CGSize(width: engName1.bounds.size.width+1,height: engName1.bounds.size.height+1))
                
                //interestName1.font = UIFont.systemFont(ofSize: 14)
               
                interestView1.layer.borderColor = UIColor.white.cgColor
                interestView1.layer.borderWidth = 0
                interestName1.textColor = UIColor.white
                
                
            }
            else {
                //interestName1.font = UIFont.systemFont(ofSize: 13)
                //interestName1.font = UIFont(name: interestName1.font.fontName, size: 13)
                backImg1.frame = CGRect(origin: CGPoint(x:backImg1.frame.origin.x+1, y: backImg1.frame.origin.y+1), size: CGSize(width: backImg1.bounds.size.width-1,height: backImg1.bounds.size.height-1))
                engName1.frame = CGRect(origin: CGPoint(x:engName1.frame.origin.x+1, y: engName1.frame.origin.y+1), size: CGSize(width: engName1.bounds.size.width-1,height: engName1.bounds.size.height-1))
                interestImg1.frame = CGRect(origin: CGPoint(x:interestImg1.frame.origin.x+1, y: interestImg1.frame.origin.y+1), size: CGSize(width: interestImg1.bounds.size.width-1,height: interestImg1.bounds.size.height-1))
                interestName1.frame = CGRect(origin: CGPoint(x:interestName1.frame.origin.x+1, y: interestName1.frame.origin.y+1), size: CGSize(width: interestName1.bounds.size.width-1,height: interestName1.bounds.size.height-1))
                interestView1.layer.borderColor = UIColor.green.cgColor
                interestView1.layer.borderWidth = 3
                interestName1.textColor = UIColor.green
                
                isTappedObjects[0] = true;
            }
            
        }
        
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
        if let Iname1: String = imgName[0]
        {
            interestImg1.image = UIImage(named: Iname1)
        }
        if let Bname1: String = tagBack[0]
        {
            backImg1.image = UIImage(named: Bname1)
        }
        if let Tname1: String = tagName[0]
        {
            if(Tname1 != ""){interestName1.isHidden = false}
            interestName1.text = Tname1
        }
        if let Ename1: String = tagEngName[0]
        {
            if(Ename1 != ""){engName1.isHidden = false}
            engName1.text = Ename1
        }
    }
    
    
    
    func roundedCornerBack1()
    {
        interestView1.layer.cornerRadius = 3
        interestView1.layer.masksToBounds = true
        
    }
}
