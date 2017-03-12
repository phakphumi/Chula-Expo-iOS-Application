//
//  AboutAppTableViewCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 3/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class AboutAppTableViewCell: UITableViewCell {

    @IBOutlet var headLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var background: UIView!
    
    
    var imageThumb: UIImage?{
        didSet{
            background.cardStyle(background: background)
            thumbnailImageView.image = imageThumb
        }
    }
    var head: String?{
        didSet{
            headLabel.text = head
        }
    }
    var desc: String?{
        didSet{
            descLabel.text = desc
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

}
