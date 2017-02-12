//
//  FourthViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 12/26/2559 BE.
//  Copyright © 2559 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CoreData

//extension UIView {
//    
//    var parentViewController: UIViewController? {
//        
//        var parentResponder: UIResponder? = self
//        
//        while parentResponder != nil {
//            
//            parentResponder = parentResponder!.next
//            
//            if let viewController = parentResponder as? UIViewController {
//                
//                return viewController
//                
//            }
//            
//        }
//        
//        return nil
//        
//    }
//    
//}

class FourthViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        createGradientNavBar()
        self.title = "Me"
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    

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
            menu(name: "About", icon: "aboutIcon"),
            menu(name: "Help", icon: "helpIcon"),
            menu(name: "Log out", icon: "helpIcon")
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
            return 4
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
        else {
            return 60
        }
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        //logout
        if indexPath.section == 2 && indexPath.row == 3 {
            
                   }
        
        return indexPath
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectMenu"{
            if let dest = segue.destination as? EventsTableViewController{
                dest.facity = (sender as? FourthMenuTableViewCell)?.name
                dest.managedObjectContext = managedObjectContext
            }
            segue.destination.title = (sender as? FourthMenuTableViewCell)?.name
        }
    }  
    
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
    
    
    class func fetchActivityDetails( activityId: String, inManageobjectcontext context: NSManagedObjectContext ) -> ActivityData? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
        request.predicate = NSPredicate(format: "activityId = %@", activityId)
        
        do {
            let result = try context.fetch(request).first as? ActivityData
            return result
        } catch {
            print("Couldn't fetch results")
        }
        return nil
    }

}
