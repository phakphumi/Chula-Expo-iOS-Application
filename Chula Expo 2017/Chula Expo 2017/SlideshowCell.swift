//
//  SlideshowCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class SlideshowCell: UITableViewCell {
    
    @IBOutlet var slideshowView: UIView!
    
    var slideshowImage = [UIImageView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slideshowView.bounds.width, height: slideshowView.bounds.height))
        imageView.image = UIImage(named: "chula_expo_logo.png")
        
        slideshowImage.append(imageView)
        slideshowView.addSubview(slideshowImage[0])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
