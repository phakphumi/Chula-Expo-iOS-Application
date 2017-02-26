//
//  FourthHeadTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FourthHeadTableViewCell: UITableViewCell {

    @IBOutlet weak var headImg: UIImageView!
    {
        didSet{
            roundedCornerLogo()
        }
    }
    var name: String?
    {
        didSet{
            print("FMFMFM\(name)")
            updateUI()
        }
    }
    var icon: String?
    {
        
        didSet{
            
            print("FMFMFMII\(icon)")
            updateUI()
        }
    }
    
    
    
    @IBOutlet weak var headName: UILabel!
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
        headImg.image = nil
        headName.text = nil
        
        //Set new data
        if let Iname1: String = icon
        {
            headImg.image = UIImage(named: Iname1)
        }
        if let Tname1: String = name
        {
            headName.text = Tname1
        }
        
    }

   
    func roundedCornerLogo()
    {
        headImg.layer.cornerRadius = headImg.bounds.height / 2
        headImg.layer.masksToBounds = true
    }

    
}
