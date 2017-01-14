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
    @IBOutlet weak var interestName2: UILabel!
    @IBOutlet weak var interestName3: UILabel!
    
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
    
    func roundedCornerLogo1()
    {
        interestImg1.layer.cornerRadius = interestImg1.bounds.height / 2
        interestImg1.layer.masksToBounds = true
    }
    func roundedCornerLogo2()
    {
        interestImg2.layer.cornerRadius = interestImg2.bounds.height / 2
        interestImg2.layer.masksToBounds = true
    }
    func roundedCornerLogo3()
    {
        interestImg3.layer.cornerRadius = interestImg3.bounds.height / 2
        interestImg3.layer.masksToBounds = true
    }
    

}
