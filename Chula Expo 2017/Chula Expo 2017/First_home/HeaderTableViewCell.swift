//
//  HeaderTableViewCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/24/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

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
//        cardStyle(background: background)
    }
}
extension UIView{

    func cardStyle(background: UIView){
        background.layer.cornerRadius = 2
        background.clipsToBounds = true
        let shadowPath = UIBezierPath(rect: background.bounds)
        background.layer.masksToBounds = false
        background.layer.shadowColor = UIColor.darkGray.cgColor
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowRadius = 1
        background.layer.shadowOpacity = 0.2
        background.layer.shadowPath = shadowPath.cgPath
    }
    
}
