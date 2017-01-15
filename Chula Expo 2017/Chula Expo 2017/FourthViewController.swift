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
            menu(name: "Setting", icon: <#T##String#>)
        ]
        
    ]

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var NumberOfRow = tagList.count/3
        if tagList.count%3 != 0
        {
            NumberOfRow += 1
        }
        return NumberOfRow
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath)
        
        if let interestCell = cell as? InterestTableViewCell
        {
            if tagList.count > indexPath.row*3 {
                interestCell.imgName[0] = tagList[indexPath.row*3+0].imgName
                interestCell.tagName[0] = tagList[indexPath.row*3+0].tagName
            }
            if tagList.count > indexPath.row*3+1 {
                interestCell.imgName[1] = tagList[indexPath.row*3+1].imgName
                interestCell.tagName[1] = tagList[indexPath.row*3+1].tagName
            }
            if tagList.count > indexPath.row*3+2 {
                interestCell.imgName[2] = tagList[indexPath.row*3+2].imgName
                interestCell.tagName[2] = tagList[indexPath.row*3+2].tagName
            }
        }
        cell.selectionStyle = .none
        return cell
        // Configure the cell...
    }
    


}
