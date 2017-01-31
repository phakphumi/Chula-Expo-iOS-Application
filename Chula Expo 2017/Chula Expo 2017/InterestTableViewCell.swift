//
//  InterestTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/14/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class InterestTableViewCell: UITableViewCell {

    @IBOutlet weak var backImg1: UIImageView!
    @IBOutlet weak var backImg2: UIImageView!
    @IBOutlet weak var backImg3: UIImageView!
    @IBOutlet weak var interestImg1: UIImageView!
    {
        didSet{
          
            roundedCornerLogo1()
        }
    }
    @IBOutlet weak var interestImg2: UIImageView!
    {
        didSet{
            roundedCornerLogo2()
        }
    }
    @IBOutlet weak var interestImg3: UIImageView!
    {
        didSet{
            roundedCornerLogo3()
        }
    }
    @IBOutlet weak var interestName1: UILabel!
    {
        didSet{
            roundedCornerLabel1()
        }
    }
    @IBOutlet weak var interestName2: UILabel!
    {
        didSet{
            roundedCornerLabel2()
        }
    }
    @IBOutlet weak var interestName3: UILabel!
    {
        didSet{
            roundedCornerLabel3()
        }
    }
    var isTappedObjects: [Bool] = [false,false,false]
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

    @IBOutlet weak var interestView: UIView!
    {
        didSet{
            roundedCornerBack1()
        }
    }

    @IBOutlet weak var interestView2: UIView!
    {
        didSet{
            roundedCornerBack2()
        }
    }
    @IBOutlet weak var interestView3: UIView!    {
        didSet{
            roundedCornerBack3()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        interestName1.isUserInteractionEnabled = true
        interestName2.isUserInteractionEnabled = true
        interestName3.isUserInteractionEnabled = true
        
        roundedCornerLogo1()
        roundedCornerLogo2()
        roundedCornerLogo3()
        
        roundedCornerBack1()
        roundedCornerBack2()
        roundedCornerBack3()
        
        self.interestView.setNeedsLayout()
        self.interestView.layoutIfNeeded()
        
        interestName1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        interestName2.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        interestName3.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(InterestedViewController.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(InterestedViewController.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer2.numberOfTapsRequired = 1
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(InterestedViewController.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer3.numberOfTapsRequired = 1
        
        interestName1.addGestureRecognizer(tapGestureRecognizer1)
        interestName2.addGestureRecognizer(tapGestureRecognizer2)
        interestName3.addGestureRecognizer(tapGestureRecognizer3)
        
           }
    
    
    func wasTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        print("tap")
        let imageView = gestureRecognizer.view as? UILabel
        if imageView?.text != nil {
            if imageView?.tag == 0{
                if isTappedObjects[0] == true{
                    isTappedObjects[0] = false;
                    
                        interestView.layer.borderColor = UIColor.white.cgColor
                        interestView.layer.borderWidth = 0
                        interestName1.textColor = UIColor.white
                    
                    
                }
                else {
                    
                    interestView.layer.borderColor = UIColor.green.cgColor
                    interestView.layer.borderWidth = 3
                    interestName1.textColor = UIColor.green
                    
                    isTappedObjects[0] = true;
                }
            }
            if imageView?.tag == 1{
                if isTappedObjects[1] == true {
                    isTappedObjects[1] = false;
                        interestView2.layer.borderColor = UIColor.white.cgColor
                        interestView2.layer.borderWidth = 0
                        interestName2.textColor = UIColor.white
                }
                else {
                    
                    interestView2.layer.borderColor = UIColor.green.cgColor
                    interestView2.layer.borderWidth = 3
                    interestName2.textColor = UIColor.green
                    
                    isTappedObjects[1] = true;
                }
            }
            if imageView?.tag == 2{
                if isTappedObjects[2] == true{
                    isTappedObjects[2] = false;
                        interestView3.layer.borderColor = UIColor.white.cgColor
                        interestView3.layer.borderWidth = 0
                        interestName3.textColor = UIColor.white
                    
                    
                }
                else {
                    interestView3.layer.borderColor = UIColor.green.cgColor
                    interestView3.layer.borderWidth = 3
                    interestName3.textColor = UIColor.green
                    
                    isTappedObjects[2] = true;
                }
            }
            

        }
        

        
       

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(){
        //Reset old data
        interestImg1.image = nil
        interestName1.text = nil
        backImg1.image = nil
        interestName1.isHidden = true
        
        interestImg2.image = nil
        interestName2.text = nil
        backImg2.image = nil
        interestName2.isHidden = true
        
        interestImg3.image = nil
        interestName3.text = nil
        backImg3.image = nil
        interestName3.isHidden = true
        
        
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
        if let Iname2: String = imgName[1]
        {
            interestImg2.image = UIImage(named: Iname2)
        }
        if let Bname2: String = tagBack[1]
        {
            backImg2.image = UIImage(named: Bname2)
        }
        if let Tname2: String = tagName[1]
        {
            if(Tname2 != ""){interestName2.isHidden = false}
            interestName2.text = Tname2
        }
        if let Iname3: String = imgName[2]
        {
            interestImg3.image = UIImage(named: Iname3)
        }
        if let Bname3: String = tagBack[2]
        {
            backImg3.image = UIImage(named: Bname3)
        }
        if let Tname3: String = tagName[2]
        {
            if(Tname3 != ""){interestName3.isHidden = false}
            interestName3.text = Tname3
        }

    }
    
    func roundedCornerBack1()
    {
        interestView.layer.cornerRadius = 4
        interestView.layer.masksToBounds = true
        
    }
    func roundedCornerBack2()
    {
        interestView2.layer.cornerRadius = 4
        interestView2.layer.masksToBounds = true
        
    }
    func roundedCornerBack3()
    {
        interestView3.layer.cornerRadius = 4
        interestView3.layer.masksToBounds = true
        
    }
    func roundedCornerLogo1()
    {
        interestImg1.layer.cornerRadius = 2.5
        interestImg1.layer.masksToBounds = true
        
    }
    func roundedCornerLogo2()
    {
        interestImg2.layer.cornerRadius = 2.5
        interestImg2.layer.masksToBounds = true
    }
    func roundedCornerLogo3()
    {
        interestImg3.layer.cornerRadius = 2.5
        interestImg3.layer.masksToBounds = true
    }
    @IBOutlet weak var interestStack: UIStackView!
    func roundedCornerLabel1()
    {
        interestName1.layer.cornerRadius = 2.5
        interestName1.layer.masksToBounds = true
        
    }
    func roundedCornerLabel2()
    {
        interestName2.layer.cornerRadius = 2.5
        interestName2.layer.masksToBounds = true
    }
    func roundedCornerLabel3()
    {
        interestName3.layer.cornerRadius = 2.5
        interestName3.layer.masksToBounds = true
    }


}
