//
//  FirstViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/8/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {

    @IBOutlet var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        createGradientNavBar()
        
        homeTableView.separatorStyle = .none
        
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Slideshow", for: indexPath) as! SlideshowCell
        cell.selectionStyle = .none
        
        let slideshowView = cell.viewWithTag(cell.slideshowTag)
        
        slideshowView?.transform = CGAffineTransform(scaleX: cell.bounds.width / 375, y: cell.bounds.height / 220)
        slideshowView?.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 {

            return self.view.bounds.width * 220 / 375
            
        } else {
            
            return 100
            
        }
        
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
