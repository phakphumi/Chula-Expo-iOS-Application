//
//  HeaderTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/3/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class HeaderMeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var engLabel: UILabel!
    @IBOutlet weak var thaLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var background: UIView!
    
    var title1: String?{
        didSet{
            updateUI()
        }
    }
    var title2: String?{
        didSet{
            updateUI()
        }
    }
    var iconImage: String?{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        engLabel.text = nil
        thaLabel.text = nil
        icon.image = nil
        
        engLabel.text = title1
        thaLabel.text = title2
        if let iconI = iconImage{
            icon.image = UIImage(named: iconI)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardStyle1(background: background)
    }
}
