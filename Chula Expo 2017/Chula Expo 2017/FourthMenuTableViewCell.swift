//
//  FourthMenuTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FourthMenuTableViewCell: UITableViewCell {

    var icon: String?
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

    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(){
        //Reset old data
        menuName.text = nil
        menuImg.image = nil
        
        //Set new data
        if let ficon: String = icon
        {
            menuImg.image = UIImage(named: ficon)
        }
        if let fName: String = name
        {
            menuName.text = fName
        }
    }
    

}
