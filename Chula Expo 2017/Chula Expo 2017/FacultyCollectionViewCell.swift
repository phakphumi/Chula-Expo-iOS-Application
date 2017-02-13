//
//  FacultyCollectionViewCell.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/7/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FacultyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var tagLabel: CapsuleUILabel!
    
    var bg: String?{
        didSet{
            updateUI()
        }
    }
    var icon: String?{
        didSet{
            updateUI()
        }
    }
    var name: String?{
        didSet{
            updateUI()
        }
    }
    var sub: String?{
        didSet{
            updateUI()
        }
    }
    var tagname: String?{
        didSet{
            if tagname != nil{
                tagLabel.setText(name: tagname!)
            }
            else{
                tagLabel.text = nil
            }
        }

    }
    var tagColor: UIColor?{
        didSet{
            tagLabel.backgroundColor = tagColor ?? UIColor.clear
        }
    }
    
    private func updateUI(){
        bgImage.image = nil
        iconImage.image = nil
        nameLabel.text = nil
        subLabel.text = nil
            
        if let bg = bg{
            bgImage.image = UIImage(named: bg)
        }
        if let icon = icon{
            iconImage.image = UIImage(named: icon)
        }
        if let name = name{
            nameLabel.text = name
        }
        if let sub = sub{
            subLabel.text = sub
        }
       
    }

}
