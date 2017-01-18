//
//  InterestedTableViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/14/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit


class InterestedTableViewController: UITableViewController {
    var tapped = [UIImageView]()
    
    struct tag {
        var imgName: String = ""
        var tagName: String = ""
    }
    
    var tagList : [tag] = [
        tag(imgName: "technology",     tagName: "Technology1"),
        tag(imgName: "technology",     tagName: "Technology2"),
        tag(imgName: "technology",     tagName: "Technology3"),
        tag(imgName: "technology",     tagName: "Technology4"),
        tag(imgName: "technology",     tagName: "Technology5"),
        tag(imgName: "technology",     tagName: "Technology6"),
        tag(imgName: "technology",     tagName: "Technology7")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientNavBar()
        self.title = "Select your interest"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footerView : UIView?
        footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 50))
        footerView?.backgroundColor = UIColor.blackColor()
        
        let dunamicButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        dunamicButton.backgroundColor = UIColor.greenColor()
        dunamicButton.setTitle("Button", forState: UIControlState.Normal)
        dunamicButton.frame = CGRectMake(0, 0, 100, 50)
        dunamicButton.addTarget(self, action: "buttonTouched:", forControlEvents: UIControlEvents.TouchUpInside)
        
        footerView?.addSubview(dunamicButton)
        
        return footerView
    }
    
    func buttonTouched(sender:UIButton!){
        println("diklik")
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 20
        }
        else {
            return self.view.bounds.width * 120 / 375
        }
    }

    
        
    func wasTapped(gestureRecognizer: UITapGestureRecognizer) {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var NumberOfRow = tagList.count/3
        if tagList.count%3 != 0
        {
            NumberOfRow += 1
        }
        return NumberOfRow+1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
        }
        else {
             cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath)
            if let interestCell = cell as? InterestTableViewCell {
        
                if tagList.count > (indexPath.row-1)*3 {
                    interestCell.imgName[0] = tagList[(indexPath.row-1)*3+0].imgName
                    interestCell.tagName[0] = tagList[(indexPath.row-1)*3+0].tagName
                }
                if tagList.count > (indexPath.row-1)*3+1 {
                    interestCell.imgName[1] = tagList[(indexPath.row-1)*3+1].imgName
                    interestCell.tagName[1] = tagList[(indexPath.row-1)*3+1].tagName
                }
                if tagList.count > (indexPath.row-1)*3+2 {
                    interestCell.imgName[2] = tagList[(indexPath.row-1)*3+2].imgName
                    interestCell.tagName[2] = tagList[(indexPath.row-1)*3+2].tagName
                }
            }
        }
        cell.selectionStyle = .none
        return cell
        // Configure the cell...
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func createGradientNavBar() {
        
        //Begin, define gradient color shade from RGB(202,92,171) to RGB(144,112,196)
        let headGradientColor = UIColor(red: 0.73, green: 0.15, blue: 0.56, alpha: 1).cgColor
        let tailGradientColor = UIColor(red: 0.46, green: 0.13, blue: 0.61, alpha: 1).cgColor
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
