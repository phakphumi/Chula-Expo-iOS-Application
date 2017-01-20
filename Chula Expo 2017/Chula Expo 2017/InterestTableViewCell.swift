//
//  InterestTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/14/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class InterestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var interestImg1: UIImageView!
    {
        didSet{
        }
    }
    @IBOutlet weak var interestImg2: UIImageView!
    {
        didSet{
        }
    }
    @IBOutlet weak var interestImg3: UIImageView!
    {
        didSet{
        }
    }
    @IBOutlet weak var interestName1: UILabel!
    @IBOutlet weak var interestName2: UILabel!
    @IBOutlet weak var interestName3: UILabel!
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        interestImg1.isUserInteractionEnabled = true
        interestImg2.isUserInteractionEnabled = true
        interestImg3.isUserInteractionEnabled = true
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(InterestedViewController.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(InterestedViewController.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer2.numberOfTapsRequired = 1
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(InterestedViewController.wasTapped(gestureRecognizer:)))
        tapGestureRecognizer3.numberOfTapsRequired = 1
        
        interestImg1.addGestureRecognizer(tapGestureRecognizer1)
        interestImg2.addGestureRecognizer(tapGestureRecognizer2)
        interestImg3.addGestureRecognizer(tapGestureRecognizer3)
        
    }
    
    
    func wasTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        print("tap")
        let imageView = gestureRecognizer.view as? UIImageView
        if imageView?.image != nil {
            if imageView?.tag == 0{
                if isTappedObjects[0] == true{
                    isTappedObjects[0] = false;
                    if let Iname1: String = imgName[0]
                    {
                        interestImg1.image = UIImage(named: Iname1)
                    }
                    
                }
                else {
                    imageView?.image = UIImage(named: "chula_expo_logo")
                    isTappedObjects[0] = true;
                }
            }
            if imageView?.tag == 1{
                if isTappedObjects[1] == true {
                    isTappedObjects[1] = false;
                    if let Iname2: String = imgName[1]
                    {
                        interestImg2.image = UIImage(named: Iname2)
                    }
                }
                else {
                    imageView?.image = UIImage(named: "chula_expo_logo")
                    isTappedObjects[1] = true;
                }
            }
            if imageView?.tag == 2{
                if isTappedObjects[2] == true{
                    isTappedObjects[2] = false;
                    if let Iname3: String = imgName[2]
                    {
                        interestImg3.image = UIImage(named: Iname3)
                    }
                    
                }
                else {
                    imageView?.image = UIImage(named: "chula_expo_logo")
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
        
        
        interestImg2.image = nil
        interestName2.text = nil
        
        
        interestImg3.image = nil
        interestName3.text = nil
        
        //Set new data
        if let Iname1: String = imgName[0]
        {
            interestImg1.image = UIImage(named: Iname1)
        }
        if let Tname1: String = tagName[0]
        {
            interestName1.text = Tname1
        }
        
        if let Iname2: String = imgName[1]
        {
            interestImg2.image = UIImage(named: Iname2)
        }
        if let Tname2: String = tagName[1]
        {
            interestName2.text = Tname2
        }
        
        if let Iname3: String = imgName[2]
        {
            interestImg3.image = UIImage(named: Iname3)
        }
        if let Tname3: String = tagName[2]
        {
            interestName3.text = Tname3
        }
    }
    

}
