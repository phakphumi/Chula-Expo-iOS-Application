//
//  FAQTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    
    @IBOutlet weak var A: UILabel!
    @IBOutlet weak var Q: UILabel!
    
    var Question: String?{
        didSet{
            updateUI()
        }
    }
    var Answer: String?{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        Q.text = nil
        A.text = nil
        
        
        Q.text = Question
        A.text = Answer
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
