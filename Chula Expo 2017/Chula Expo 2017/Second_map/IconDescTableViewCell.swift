//
//  IconDescTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 3/2/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class IconDescTableViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descTh: UILabel!
    @IBOutlet weak var descEn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
        descTh.frame = CGRect(x: descTh.frame.origin.x, y: descTh.frame.origin.y, width: UIScreen.main.bounds.width * 0.225, height: descTh.frame.height)
        descEn.frame = CGRect(x: descEn.frame.origin.x, y: descEn.frame.origin.y, width: UIScreen.main.bounds.width * 0.225, height: descEn.frame.height)
        
    }
    
    override func layoutSubviews() {
        
        iconView.layer.cornerRadius = iconView.frame.height / 2
        //        facultyIcon.layer.borderWidth = 3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
