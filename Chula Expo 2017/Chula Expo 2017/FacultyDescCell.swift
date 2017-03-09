//
//  FacultyDescCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/26/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FacultyDescCell: UITableViewCell {
    
    var facityTitle: String? {
        
        didSet{
            updateUI()
        }
    }
    
    var facityDesc: String? {
        
        didSet{
            updateUI()
        }
    }
    
    var facTag: String?{
        didSet{
            if let tag = facTag{
                tagCap.setText(name: tag)
            }
            else{
                tagCap.text = nil
            }
        }
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var tagCap: CapsuleUILabel!

    private func updateUI(){
        
        titleLabel.text = nil
        descLabel.text = nil
        
        if let title = facityTitle {
            
            titleLabel.text = title
            
        }
        if let desc = facityDesc {
            
            descLabel.text = desc
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
