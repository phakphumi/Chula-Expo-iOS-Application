//
//  FacityTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FacityTableViewController: UITableViewController {
    
    struct facity
    {
        var name: String = ""
        var logoName: String = ""
    }
    
    var facityList : [Array<facity>] =
    [
        [facity(name: "Smart City",     logoName: "smartLogo")
        ,facity(name: "Health City",    logoName: "smartLogo")
        ,facity(name: "Human City",     logoName: "smartLogo")
        ],
        [facity(name: "Faculty of Engineering",         logoName: "smartLogo")
        ,facity(name: "Faculty of Arts",                logoName: "smartLogo")
        ,facity(name: "Faculty of Science",             logoName: "smartLogo")
        ,facity(name: "Faculty of Political Science",   logoName: "smartLogo")
        ,facity(name: "Faculty of Architecture",        logoName: "smartLogo")
        ,facity(name: "Faculty of Commerce and Accountancy", logoName: "smartLogo")
        ,facity(name: "Faculty of Education",           logoName: "smartLogo")
        ,facity(name: "Faculty of Communication Arts",  logoName: "smartLogo")
        ,facity(name: "Faculty of Economics",           logoName: "smartLogo")
        ,facity(name: "Faculty of Medicine",            logoName: "smartLogo")
        ,facity(name: "Faculty of Veterinary Science",  logoName: "smartLogo")
        ,facity(name: "Faculty of Dentistry",           logoName: "smartLogo")
        ,facity(name: "Faculty of Pharmaceutical Science", logoName: "smartLogo")
        ,facity(name: "Faculty of Law",                 logoName: "smartLogo")
        ,facity(name: "Faculty of Fine and Applied Arts", logoName: "smartLogo")
        ,facity(name: "Faculty of Allied Health Sciences", logoName: "smartLogo")
        ,facity(name: "Faculty of Psychology",          logoName: "smartLogo")
        ,facity(name: "Faculty of Sports Sciece",       logoName: "smartLogo")
        ,facity(name: "Faculty of Agricultural Resources", logoName: "smartLogo")
        ]
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Events"
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return facityList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return facityList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "facityCell", for: indexPath)
        
        if let facityCell = cell as? FacityTableViewCell
        {
            facityCell.name = facityList[indexPath.section][indexPath.row].name
            facityCell.logo = facityList[indexPath.section][indexPath.row].logoName
        }
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0){
            return "CITY"
        }
        if (section == 1){
            return "FACULTY"
        }
        return nil
    }
}
