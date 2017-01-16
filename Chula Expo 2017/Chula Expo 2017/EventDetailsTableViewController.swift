//
//  EventDetailsTableViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class EventDetailsTableViewController: UITableViewController {
    
    var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var topicLabel: UILabel!
    var cancelButton: UIButton!
    var shareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        print("viewdidload")
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
            
        return 20
            
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
            
        } else if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "WhenAndWhereCell", for: indexPath) as! WhenAndWhereTableViewCell
            
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
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
            
            return 267
            
        } else if indexPath.row == 0 {
            
            return 55
            
        }
        
        return 40
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(section)
        if section == 1 {
            
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
            headerView.backgroundColor = UIColor.white
            
            topicLabel = UILabel(frame: CGRect(x: 20, y: 17, width: 0, height: 0))
            topicLabel.font = UIFont.systemFont(ofSize: 23)
            topicLabel.text = "Robot vacuum show"
            topicLabel.sizeToFit()
            topicLabel.textColor = UIColor.black
            
            cancelButton = UIButton(frame: CGRect(x: 17, y: (64 - 20) / 2 - 12.5 + 20, width: 25, height: 25))
            cancelButton.setImage(#imageLiteral(resourceName: "cross_black"), for: .normal)
            cancelButton.alpha = 0
            cancelButton.addTarget(self, action: #selector(EventDetailsTableViewController.cancel), for: .touchUpInside)
            
            shareButton = UIButton(frame: CGRect(x: 344, y: (64 - 20) / 2 - 12.5 + 20, width: 14, height: 20))
            shareButton.setImage(#imageLiteral(resourceName: "share"), for: .normal)
            shareButton.alpha = 0
            shareButton.addTarget(self, action: #selector(EventDetailsTableViewController.share), for: .touchUpInside)
            
            
            headerView.addSubview(cancelButton)
            headerView.addSubview(shareButton)
            headerView.addSubview(topicLabel)
            
            return headerView
            
        }
        
        return nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -self.view.bounds.height * 0.2 {
            
            self.dismiss(animated: true, completion: nil)
            
        } else if scrollView.contentOffset.y < 0 {
            
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent((self.view.bounds.height * 0.2 + scrollView.contentOffset.y ) / (self.view.bounds.height * 0.2))
            
        } else if scrollView.contentOffset.y > 267 {

            tableView.beginUpdates()

            headerView.frame = CGRect(x: 0, y: self.headerView.frame.origin.y, width: headerView.frame.width, height: 64)
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.cancelButton.alpha = 1
                
                self.shareButton.alpha = 1
                
                self.topicLabel.font = self.topicLabel.font.withSize(20)
                
                self.topicLabel.sizeToFit()
                
                self.topicLabel.center = CGPoint(x: self.headerView.frame.width / 2, y: (self.headerView.frame.height - UIApplication.shared.statusBarFrame.height) / 2 + UIApplication.shared.statusBarFrame.height)
                
//                self.topicLabel.transform = CGAffineTransform(translationX: self.headerView.frame.width / 2 - self.topicLabel.frame.width / 2 - 20, y: 9)
                
                print(self.topicLabel.frame)
                
            })
            
            tableView.endUpdates()
            
        } else if scrollView.contentOffset.y <= 267 {
            
            tableView.beginUpdates()
            
            headerView.frame = CGRect(x: 0, y: self.headerView.frame.origin.y, width: headerView.frame.width, height: 50)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.cancelButton.alpha = 0
                
                self.shareButton.alpha = 0
                
                self.topicLabel.font = self.topicLabel.font.withSize(23)
                
                self.topicLabel.sizeToFit()
                
                self.topicLabel.center = CGPoint(x: 20 + self.topicLabel.frame.width / 2, y: (self.headerView.frame.height - UIApplication.shared.statusBarFrame.height) / 2 + UIApplication.shared.statusBarFrame.height)
                
//                self.topicLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                
                print(self.topicLabel.frame)
                
            })
            
            tableView.endUpdates()
            
        }
        
        
    }
    
    func cancel() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func share() {
        
        
        
    }

}
