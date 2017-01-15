//
//  EventDetailsTableViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/15/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class EventDetailsTableViewController: UITableViewController {

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
        
        print("HeightForHeaderInSection")
        
        if section == 0 {
            
            return 0
            
        }
        
        return 50
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        print("HeightForRowAt")
        
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
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
            view.backgroundColor = UIColor.white
            
            let topicLabel = UILabel(frame: CGRect(x: 20, y: 5, width: view.bounds.width - 20, height: view.bounds.height))
            topicLabel.font = UIFont.systemFont(ofSize: 23)
            topicLabel.text = "Robot vacuum show"
            topicLabel.textColor = UIColor.black
            
            view.addSubview(topicLabel)
            
            return view
            
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
            
        } else if scrollView.contentOffset.y >= 0 {
            
            
            
        }
        
        
    }

//    func addImageToNavigationBar() {
//        
//        navigationController?.navigationBar.frame = CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: self.view.bounds.width, height: self.view.bounds.height * 0.4)
//        
//        let topicImage = UIImageView(frame: (navigationController?.navigationBar.frame)!)
//        topicImage.image = #imageLiteral(resourceName: "event_detail_temp")
//        topicImage.contentMode = .scaleAspectFill
//        
//        navigationController?.navigationBar.addSubview(topicImage)
//        
//    }
//    
//    func addCancelButtonToNavigationBar() {
//        
//        let xScale = self.view.bounds.width * 0.037
//        let yScale = self.view.bounds.height * 0.048
//        let widthAndHeightScale = self.view.bounds.height * 0.038
//        
//        let cancelButton = UIButton(frame: CGRect(x: xScale, y: yScale, width: widthAndHeightScale, height: widthAndHeightScale))
//        cancelButton.imageView?.image = cross
//        
//        navigationController?.navigationBar.addSubview(cancelButton)
//        
//    }

}
