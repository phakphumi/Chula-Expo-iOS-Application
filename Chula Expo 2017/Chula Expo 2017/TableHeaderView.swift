//
//  TableHeaderView.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/24/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {

    @IBOutlet weak var engTitle: UILabel!
    @IBOutlet weak var thaTitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
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
        engTitle.text = nil
        thaTitle.text = nil
        icon.image = nil
        
        engTitle.text = title1
        thaTitle.text = title2
        if let iconI = iconImage{
            icon.image = UIImage(named: iconI)
        }
    }
}
