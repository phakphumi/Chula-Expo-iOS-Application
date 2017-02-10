//
//  FacityTableViewCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FacityTableViewCell: UITableViewCell {
    
    var logo: String?
    {
        didSet{
            updateUI()
        }
    }
    
    var name: String?
    {
        didSet{
            updateUI()
        }
    }

    @IBOutlet weak var facCapsule: CapsuleUILabel!
    @IBOutlet weak var facityLogo: UIImageView!
    {
        didSet{
            roundedCornerLogo()
        }
    }
    
    @IBOutlet weak var facityName: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateUI(){
        //Reset old data
        facityName.text = nil
        facityLogo.image = nil
        
        //Set new data
        if let fLogo: String = logo
        {
            facityLogo.image = UIImage(named: fLogo)
        }
        if let fName: String = name
        {
            facityName.text = fName
        }
        makeCapsule()
    }

    func roundedCornerLogo()
    {
        facityLogo.layer.cornerRadius = facityLogo.bounds.height / 2
        facityLogo.layer.masksToBounds = true
    }
    func makeCapsule(){
        facCapsule.layer.cornerRadius = facCapsule.bounds.height/2
        facCapsule.layer.masksToBounds = true
    }
    
}
