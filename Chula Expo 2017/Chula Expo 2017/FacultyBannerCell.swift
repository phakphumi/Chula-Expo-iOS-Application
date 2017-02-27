//
//  FacultyBannerCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/26/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FacultyBannerCell: UITableViewCell {
    
    var bannerUrl: String?{
        
        didSet{
            
            updateUI()
            
        }
    }

    @IBOutlet var bannerImage: UIImageView!
    
    
    private func updateUI() {
        
        if let banUrl = bannerUrl {
            
            bannerImage.imageFromServerURL(urlString: banUrl)
        
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
