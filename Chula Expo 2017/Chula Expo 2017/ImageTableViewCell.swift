//
//  ImageTableViewCell.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBAction func cancel(_ sender: UIButton) {
        
        let tableView = self.superview?.superview as! UITableView
        let tableViewController = tableView.dataSource as! UITableViewController
        
        tableViewController.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func share(_ sender: UIButton) {
        
        let tableView = self.superview?.superview as! UITableView
        let tableViewController = tableView.dataSource as! UITableViewController
        
        
        
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
