//
//  DocumentTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var documentView: UIView!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        documentView.layer.borderWidth = 2
        documentView.layer.borderColor = UIColor(red: 0.694, green: 0.22, blue: 0.227, alpha: 1).cgColor
        documentView.layer.cornerRadius = 4
        documentView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
