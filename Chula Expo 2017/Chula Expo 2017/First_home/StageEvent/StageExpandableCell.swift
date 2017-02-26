//
//  StageExpandableCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class StageExpandableCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var background: UIView!
    
    var time: String?
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
    
    private func updateUI(){
        timeLabel.text = nil
        nameLabel.text = nil
        
        if let time1 = time{
            
            timeLabel.text = time1
        }
        if let name1 = name{
        
            nameLabel.text = name1
            cardStyle(background: background)
        }

    }
    
    func expandTitle(){
        
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor(red:1.00, green:0.42, blue:0.60, alpha:1.0)
        nameLabel.lineBreakMode = .byWordWrapping
        
    }
    
    func closeTitle(){
        
        nameLabel.numberOfLines = 1
        nameLabel.textColor = UIColor.black
        nameLabel.lineBreakMode = .byTruncatingTail

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
