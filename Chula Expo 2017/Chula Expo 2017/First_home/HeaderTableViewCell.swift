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
            engLabel.text = title1
        }
    }
    var title2: String?{
        didSet{
            thaLabel.text = title2
        }
    }
    var iconImage: String?{
        didSet{
            icon.image = UIImage(named: iconImage ?? "heartIcon")
        }
    }
    
    private func updateUI(){
    }

}

extension UIView{

    func cardStyle(background: UIView){
        background.layer.cornerRadius = 2
        background.clipsToBounds = true
        
//        background.clipsToBounds = false

//        self.layer.masksToBounds = false
        
        let shadowPath = UIBezierPath(rect: background.bounds)
        background.layer.shadowColor = UIColor.darkGray.cgColor
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowRadius = 1
        background.layer.shadowOpacity = 0.2
        background.layer.shadowPath = shadowPath.cgPath
    }
    
}
