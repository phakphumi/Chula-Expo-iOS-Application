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
