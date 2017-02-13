//
//  StageDetailCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/2/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class StageDetailCell: UITableViewCell {
    
    @IBOutlet var descLabel: UILabel!
    
//    var textAttribute = NSAttributedString()
    
//    override func layoutSubviews() {
//        
//        textAttribute = descLabel.attributedText!
//    }
    
    var desc: String?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI () {
        
        if let desc = desc{
//            descLabel. = textAttribute.heightWithConstrainedWidth(width: descLabel.bounds.width)
            descLabel.text = desc
            descLabel.sizeToFit()
            
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

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
