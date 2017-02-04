//
//  EventDetailTableViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/31/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class EventDetailTableViewController: UITableViewController {
    
    var reloadCount = 0
    
    var images = [#imageLiteral(resourceName: "robot6"), #imageLiteral(resourceName: "robot9"), #imageLiteral(resourceName: "robot5"), #imageLiteral(resourceName: "robot12"), #imageLiteral(resourceName: "robot10"), #imageLiteral(resourceName: "robot11")]
    var dates = ["15 มีนาคม", "16 มีนาคม", "17 มีนาคม", "18 มีนาคม", "19 มีนาคม"]
    var times = [
                ["08.00-09.00", "10.00-11.00", "13.00-14.00"],
                ["09.00-10.00", "11.00-12.00", "14.00-15.00"],
                ["08.00-09.00", "10.00-11.00", "13.00-14.00", "15.00-16.00"],
                ["09.00-10.00", "11.00-12.00", "14.00-15.00"],
                ["08.00-09.00", "10.00-11.00"]
               ]

    @IBAction func cancel(_ sender: UIButton) {
    
        toDismiss()
    
    }
    
    func toDismiss() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            
        }) { (success) in
            
            if success {
                
                self.dismiss(animated: false, completion: nil)
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(EventDetailsTableViewController.toDismiss))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
        
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
        
        let cell: UITableViewCell!
        
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
            
            if let itvCell = cell as? ImageTableViewCell {
                
                itvCell.bannerImage.image = #imageLiteral(resourceName: "cryonics")
                
            }
            
        } else if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            
            if let ehvc = cell as? EventHeaderTableViewCell {
                
                ehvc.dates = self.dates
                ehvc.times = self.times
                
            }
            
        } else if indexPath.row == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DescCell", for: indexPath)
            
        } else if indexPath.row == 2 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DocCell", for: indexPath)
            
        } else if indexPath.row == 3 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell", for: indexPath)
            
            if let gtvc = cell as? GalleryTableViewCell {
            
                gtvc.images = self.images
                
            }
            
        } else if indexPath.row == 4 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath)
            
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return self.view.bounds.height * 0.42
            
        } else if indexPath.row == 0 {
            
            return 201
            
        } else if indexPath.row == 1 {
            
            return DescTableViewCell.descCellHeight
            
        } else if indexPath.row == 2 {
            
            return 71
            
        } else if indexPath.row == 3 {
            
            return 75
            
        } else if indexPath.row == 4 {
            
            return 230
            
        } else {
            
            return 45
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "presentGallery" {
            
            let destination = segue.destination as! GalleryViewController
            
//            let images = toImages.allObjects as! [ImageData]
            
            destination.images = images
            
//            for image in images {
//                
//                destination?.imageName.append(image.url!)
//                
//            }
            
        } else if segue.identifier == "presentFavorite" {
            
            let destination = segue.destination as! FavoriteViewController
            
            destination.dates = self.dates
            destination.times = self.times
            
        }
        
    }
    
    /*override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastIndexPath = tableView.numberOfRows(inSection: 1)
        
        if indexPath.row == lastIndexPath - 1 {
            
            if reloadCount < 10 {
                
                tableView.reloadData()
                
                reloadCount += 1
                
            }
            
        }
        
    }*/
    

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

}
