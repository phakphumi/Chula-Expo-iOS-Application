//
//  WhenAndWhereTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class WhenAndWhereTableViewCell: UITableViewCell {

    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateLabel.text = "Today • 9:41-10.41"
        placeLabel.text = "Room 301 Building 3"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func boundsTag() {
        
        tagLabel.layer.cornerRadius = tagLabel.bounds.height / 2
        tagLabel.layer.masksToBounds = true
        
    }
    

}
