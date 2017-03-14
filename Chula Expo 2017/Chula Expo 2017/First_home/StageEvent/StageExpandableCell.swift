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
    @IBOutlet weak var subtimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var background: UIView!
    @IBOutlet var runningDot: UIImageView!
    
    var time: String? {
        didSet{
            if let time1 = time{
                
                timeLabel.text = time1
            }
        }
    }
    
    var endTime: String? {
        didSet{
            if let time2 = endTime{
                
                subtimeLabel.text = time2
            }
        }
    }
    
    var name: String? {
        didSet{
            if let name1 = name{
                
                nameLabel.text = name1
                
            }
        }
    }
    
    
    func expandTitle(){
        
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor(red:1.00, green:0.42, blue:0.60, alpha:1.0)
        nameLabel.lineBreakMode = .byWordWrapping
        cardStyle(background: background)
    }
    
    func closeTitle(){
        
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor.black
        nameLabel.lineBreakMode = .byWordWrapping
        cardStyle(background: background)
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
