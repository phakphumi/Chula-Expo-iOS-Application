//
//  EventDetailsTableViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventDetailsTableViewController: UITableViewController {
    
    var activityId: String!
    var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var topicLabel: UILabel!
    var cancelButton: UIButton!

    @IBAction func cancel(_ sender: UIButton) {
        
        toDismiss()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        fetchEventDetails()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(EventDetailsTableViewController.toDismiss))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    func toDismiss() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.view.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            
        }) { (success) in
            
            if success {
                
                self.dismiss(animated: false, completion: nil)
                
            }
        }
        
    }
    

    
    func fetchEventDetails() {
        
        let managedObjectContext: NSManagedObjectContext? =
            (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
        
        managedObjectContext?.perform {
            
            let activityData = ActivityData.fetchActivityDetails(activityId: self.activityId, inManageobjectcontext: managedObjectContext!)
            
            print(activityData)
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            
            return 1
            
        }
            
        return 6
            
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
            
        } else if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "WhenAndWhereCell", for: indexPath)
            
            if let wawCell = cell as? WhenAndWhereTableViewCell {
                
                wawCell.boundsTag()
                
            }
            
        } else if indexPath.row == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
        } else if indexPath.row == 2 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DescCell", for: indexPath) as! DescTableViewCell
            
        } else if indexPath.row == 3 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell", for: indexPath) as! GalleryTableViewCell
            
        } else if indexPath.row == 4 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "RelatedTitleCell", for: indexPath)
            
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "RelatedCell", for: indexPath) as! RelatedTableViewCell
            
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 0
            
        }
        
        if headerView.frame.origin.y > 267 {
            
            return 64
            
        } else {
        
            return 50
        
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return self.view.bounds.height * 0.42
            
        } else if indexPath.row == 0 {
            
            return 55
            
        } else if indexPath.row == 2 {
            
            return DescTableViewCell.descTextHeight
            
        } else if indexPath.row == 3 {
            
            return GalleryTableViewCell.galleryHeight
            
        } else if indexPath.row == 5 {
            
            return RelatedTableViewCell.relatedTextHeight
            
        } else {
            
            return 55
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
            headerView.backgroundColor = UIColor.white
            
            topicLabel = UILabel(frame: CGRect(x: 20, y: 17, width: 0, height: 0))
            topicLabel.font = UIFont.systemFont(ofSize: 23)
            topicLabel.text = "Robot vacuum show"
            topicLabel.sizeToFit()
            topicLabel.textColor = UIColor.black

            cancelButton = UIButton(frame: CGRect(x: self.view.bounds.width * 0.88, y: 64 / 2 - 15, width: 30, height: 30))
//            cancelButton = UIButton(frame: CGRect(x: 17, y: self.view.bounds.height * 0.044, width: 25, height: 25))
            cancelButton.setImage(#imageLiteral(resourceName: "cross_black"), for: .normal)
            cancelButton.alpha = 0
            cancelButton.addTarget(self, action: #selector(EventDetailsTableViewController.cancel), for: .touchUpInside)
            
            
            headerView.addSubview(cancelButton)
            headerView.addSubview(topicLabel)
            
            return headerView
            
        }
        
        return nil
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3 {
            
            self.performSegue(withIdentifier: "presentGallery", sender: self)
            
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
        
//        UIApplication.shared.statusBarStyle = .default
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
        
//        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > self.view.bounds.height * 0.42 {

            tableView.beginUpdates()

            headerView.frame = CGRect(x: 0, y: self.headerView.frame.origin.y, width: headerView.frame.width, height: 64)
                
            self.cancelButton.alpha = 1
                
            self.topicLabel.font = self.topicLabel.font.withSize(20)
                
            self.topicLabel.sizeToFit()

            self.topicLabel.center = CGPoint(x: self.headerView.frame.width / 2, y: 64 / 2)

            
            tableView.endUpdates()
            
        } else if scrollView.contentOffset.y <= self.view.bounds.height * 0.42 {
            
            tableView.beginUpdates()
            
            headerView.frame = CGRect(x: 0, y: self.headerView.frame.origin.y, width: headerView.frame.width, height: 50)
                
            self.cancelButton.alpha = 0
                
            self.topicLabel.font = self.topicLabel.font.withSize(23)
                
            self.topicLabel.sizeToFit()
                
            self.topicLabel.center = CGPoint(x: 20 + self.topicLabel.frame.width / 2, y: 17 + self.topicLabel.frame.height / 2)
            
            tableView.endUpdates()
            
        }
        
    }

}
