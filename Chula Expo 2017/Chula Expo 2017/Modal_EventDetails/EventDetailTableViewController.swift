//
//  EventDetailTableViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/31/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventDetailTableViewController: UITableViewController {
    
    var didReload = false
    
    var images = [String]()
    var tags = [String]()
    var roundsId = [String]()
    var dates = [String]()
    var times = [String: [String]]()
    var dateTimeList = [String]()
//    var dates = ["15 มีนาคม", "16 มีนาคม", "17 มีนาคม", "18 มีนาคม", "19 มีนาคม"]
//    var times = [
//                ["08.00-09.00", "10.00-11.00", "13.00-14.00"],
//                ["09.00-10.00", "11.00-12.00", "14.00-15.00"],
//                ["08.00-09.00", "10.00-11.00", "13.00-14.00", "15.00-16.00"],
//                ["09.00-10.00", "11.00-12.00", "14.00-15.00"],
//                ["08.00-09.00", "10.00-11.00"]
//               ]
    
    var activityId: String!
    var bannerUrl: String!
    var topic: String!
    var locationDesc: String!
    var toRounds: NSSet!
    var reservable: Bool!
    var desc: String!
    var room: String!
    var place: String!
    var latitude: Double!
    var longitude: Double!
    var pdf: String!
    var toImages: NSSet!
    var toTags: NSSet!
    var managedObjectContext: NSManagedObjectContext?

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
        
        calculateIsReservable()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(EventDetailsTableViewController.toDismiss))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    private func calculateIsReservable() {
        
        if toRounds.allObjects.count > 0 {
            
            self.reservable = true
            
        } else {
            
            self.reservable = false
            
        }
        
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
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
            
            if let itvCell = cell as? ImageTableViewCell {
                
                if let url = bannerUrl{
                    
                    bannerUrl = "http://staff.chulaexpo.com\(url)"
                    //                let bannerData = URL(string: bannerUrl!)
                    //
                    //                if let data = NSData(contentsOf: bannerData!) {
                    
                    itvCell.bannerImage.imageFromServerURL(urlString: bannerUrl)
                    //                    image = UIImage(data: data as Data)
                    
                    //                }

                }
                
            }
            
        } else if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            
            if !didReload {
            
                if let ehvc = cell as? EventHeaderTableViewCell {
                
                    let roundsObj = toRounds.allObjects.sorted(by: { (firstObj, secondObj) -> Bool in
                        let first = firstObj as! RoundData
                        let second = secondObj as! RoundData
                        
                        return first.startTime! < second.startTime!
                        
                    }) as! [RoundData]
                
                    for round in roundsObj {
                    
                        let timeFormatter = DateFormatter()
                        let dateFormatter = DateFormatter()
                        
                        dateFormatter.dateFormat = "dd มีนาคม"
                        timeFormatter.dateFormat = "HH.mm"
                    
                        let date = dateFormatter.string(from: round.startTime!)
                        let sTime = timeFormatter.string(from: round.startTime!)
                        let eTime = timeFormatter.string(from: round.endTime!)
                    
                        if !dates.contains(date) {
                        
                            dates.append(date)
                            times[date] = [String]()
                        
                        }
                    
                        times[date]?.append("\(sTime)-\(eTime)")
                        
                        dateTimeList.append("\(date) \(sTime)-\(eTime)")
                        
                        roundsId.append(round.id!)
                    
                    }
                    
                    locationDesc = RoomData.getLocation(fromRoomId: self.room!, inManageobjectcontext: self.managedObjectContext!)
                
                    ehvc.topic = self.topic
                    ehvc.locationDesc = self.locationDesc
                    ehvc.dates = self.dates
                    ehvc.times = self.times
                    ehvc.dateTimeList = self.dateTimeList
                    ehvc.reservable = self.reservable
                
                }
                
            }
            
        } else if indexPath.row == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DescCell", for: indexPath)
            
            if let descCell = cell as? DescTableViewCell {
                
                descCell.descText.text = desc
                
            }
            
        } else if indexPath.row == 2 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DocCell", for: indexPath)
            
            if let dtvc = cell as? DocumentTableViewCell {
                
                dtvc.pdfUrl = pdf
                
            }
            
        } else if indexPath.row == 3 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell", for: indexPath)
            
            if let gtvc = cell as? GalleryTableViewCell {
                
                images.removeAll()
                
                let imagesObj = self.toImages.allObjects as! [ImageData]
                
                for image in imagesObj {
                    
                    if var url = image.url{
                        
                        url = "http://staff.chulaexpo.com\(url)"
                        //
                        //                    let imageData = URL(string: image.url!)
                        //
                        //                    if let data = NSData(contentsOf: imageData!) {
                        
                        images.append(url)
                        
                        //                    }

                    }
                    
                }
                
                gtvc.images = images
                
            }
            
        } else if indexPath.row == 4 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "MapsCell", for: indexPath)
            
            if let mvc = cell as? MapTableViewCell {
                
                mvc.latitude = self.latitude
                mvc.longitude = self.longitude
                
            }
            
        } else if indexPath.row == 5 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
            
            if let tvc = cell as? TagTableViewCell {
            
                let tagsObject = toTags.allObjects as! [TagData]
                
                for tag in tagsObject {
                    
                    tags.append(tag.name!)
            
                }
                
                tvc.tags = self.tags
                
            }
            
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
            
            destination.images = images
            
            
        } else if segue.identifier == "presentFavorite" {
            
            let destination = segue.destination as! FavoriteViewController
            
            if self.reservable! {
                
                destination.dates = self.dates
                destination.times = self.times
                
            } else {
                
                print(self.dates)
                print(self.times)
                
            }
            
            destination.activityId = self.activityId
            destination.topic = self.topic
            destination.roundsId = self.roundsId
            destination.dateTimeList = self.dateTimeList
            destination.reservable = self.reservable
            destination.managedObjectContext = self.managedObjectContext
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 1 {
            
            if !didReload {
                
                tableView.reloadData()
                
                didReload = true
                
            }
            
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

}
