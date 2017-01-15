//
//  FourthViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/26/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FourthViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My profile"
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct menu{
        var name: String
        var icon: String
    }
    
    var menuList: [Array<menu>] = [
        [
            menu(name: "Bookmarks", icon: "technology"),
            menu(name: "Reservations", icon: "technology")
        ],
        
        [
            menu(name: "Setting", icon: "technology"),
            menu(name: "About", icon: "technology"),
            menu(name: "Help", icon: "technology")
        ]
    ]
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        else if section == 1{
            return 2
        }
        else {
            return 3
        }
    }
    
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
    
        if indexPath.row == 0 && indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "headCell", for: indexPath)
            if let headCell = cell as? FourthHeadTableViewCell
            {
                headCell.name = "Fmm Fmm"
                headCell.icon = "technology"
            }
            
            cell.selectionStyle = .none
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
            if let menuCell = cell as? FourthMenuTableViewCell
            {
                menuCell.name = menuList[indexPath.section-1][indexPath.row].name
                menuCell.icon = menuList[indexPath.section-1][indexPath.row].icon
            }
        }
     //   cell.selectionStyle = .none
        return cell
        // Configure the cell...
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            return 150
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0){
            return nil
        }
        else{
            return "  "
        }
    }



}
