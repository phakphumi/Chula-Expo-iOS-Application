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
        createGradientNavBar()
        self.title = "My profile"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
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
            menu(name: "Favourites", icon: "favoriteIcon"),
            menu(name: "Reservations", icon: "reservationIcon")
        ],
        
        [
            menu(name: "Setting", icon: "settingsIcon"),
            menu(name: "About", icon: "technology"),
            menu(name: "Help", icon: "helpIcon")
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
        if (section == 0 || section == 1){
            return nil
        }
        else{
            return "  "
        }
    }

    func createGradientNavBar() {
        
        //Begin, define gradient color shade from RGB(202,92,171) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.8, green: 0.36, blue: 0.67, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.565, green: 0.44, blue: 0.77, alpha: 1).cgColor
        //
        
        //Begin, create gradient layer with 2 colors shade and start gradient from left to right
        let gradientLayer = CAGradientLayer()
        var navIncludeStatFrame = navigationController!.navigationBar.bounds
        navIncludeStatFrame.size.height += 20
        gradientLayer.frame = navIncludeStatFrame
        gradientLayer.colors = [headGradientColor, tailGradientColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //End
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.setBackgroundImage(gradientImage, for: UIBarMetrics.default)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }

}
