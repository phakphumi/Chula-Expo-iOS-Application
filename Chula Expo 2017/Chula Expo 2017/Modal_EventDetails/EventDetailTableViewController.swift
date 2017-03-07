//
//  EventDetailTableViewController.swift
//  Chula Expo 2017
//
//  Created by Pakpoom on 1/31/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

protocol EventDetailTableViewControllerDelegate {
    
    func updateData(data: String)
    
}

class EventDetailTableViewController: UITableViewController , UIGestureRecognizerDelegate {
    
    var didReload = false
//    var panGestureRecognizer: UIPanGestureRecognizer?
//    var originalPosition: CGPoint?
//    var currentPositionTouched: CGPoint?
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
    var start: Date?
    var end: Date?
    
    var timeDesc: String?
    var activityId: String!
    var bannerUrl: String!
    var topic: String!
    var locationDesc: String!
    var toRounds: NSSet!
    var reservable: Bool!
    var desc: String!
    var room: String!
    var place: String!
    var zoneId: String!
    var latitude: Double!
    var longitude: Double!
    var pdf: String!
    var toImages: NSSet!
    var toTags: NSSet!
    var managedObjectContext: NSManagedObjectContext?
    
    var alreadyShowTextAlert = false
    var fromQRScanner = false
    var delegate: EventDetailTableViewControllerDelegate?

    @IBAction func cancel(_ sender: UIButton) {
    
        self.delegate?.updateData(data: "dddd")
        
        toDismiss()
    
    }
    
    func toDismiss() {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)

        
//        UIView.animate(withDuration: 0.2, animations: {
//            
//            self.view.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
//            
//        }) { (success) in
//            
//            if success {
//                
//                //                self.dismiss(animated: false, completion: nil)
//                
//            }
//        }
        
    }
    
//    func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
//        let translation = panGesture.translation(in: view)
//        
//        if panGesture.state == .began {
//            originalPosition = view.center
//            currentPositionTouched = panGesture.location(in: view)
//        } else if panGesture.state == .changed {
//            view.frame.origin = CGPoint(
////                x: translation.x,
//                x: 0,
//                y: translation.y
//            )
//        } else if panGesture.state == .ended {
//            let velocity = panGesture.velocity(in: view)
//            
//            if velocity.y >= 1500 {
//                UIView.animate(withDuration: 0.2
//                    , animations: {
//                        self.view.frame.origin = CGPoint(
//                            x: self.view.frame.origin.x,
//                            y: self.view.frame.size.height
//                        )
//                }, completion: { (isCompleted) in
//                    if isCompleted {
////                        self.dismiss(animated: false, completion: nil)
//                        self.toDismiss()
//                    }
//                })
//            } else {
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.view.center = self.originalPosition!
//                })
//            }
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculateIsReservable()
        tableView.estimatedRowHeight = 150
        
//        UIApplication.shared.isStatusBarHidden = true
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(EventDetailTableViewController.toDismiss))
//        swipeRight.direction = .down
//        
//        self.view.addGestureRecognizer(swipeRight)
//        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        
        if UserData.isThereUser(inManageobjectcontext: managedObjectContext!) {
            
            APIController.sendComment(toActivityID: activityId, message: "Visited Activity", inManageobjectcontext: managedObjectContext!, completion: nil)
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        if UserData.isThereUser(inManageobjectcontext: managedObjectContext!) {
            
            if !alreadyShowTextAlert {
                
//                if zoneId == "5899a98a5eeecd3698f6cfc6" { // engineer
                if zoneId == "589c52b4a8bbbb1c7165d3f0" { //art gallery
                    
                    alreadyShowTextAlert = true
                    
                    createTextAlert()
                    
                }
                
            }
            
        }
        
    }
    
    private func createTextAlert() {
        
        let textAlert = UIAlertController(title: "ความรู้สึกของท่าน", message: "ร่วมแสดงความรู้สึกต่อผลงานชิ้นนี้", preferredStyle: .alert)
        
        textAlert.addTextField { (textField) in
            textField.placeholder = "ความรู้สึกของท่าน"
        }
        
        textAlert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil))
        textAlert.addAction(UIAlertAction(title: "ส่งความรู้สึก", style: .default, handler: { (alert) in
            
            let textField = textAlert.textFields![0] as UITextField
            
            APIController.sendComment(toActivityID: self.activityId, message: textField.text!, inManageobjectcontext: self.managedObjectContext!, completion: { (success) in
                
                if success {
                    
                    let alert = UIAlertController(title: "สำเร็จ", message: "ส่งความรู้สึกของท่านเรียบร้อยแล้ว", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "ล้มเหลว", message: "เกิดความผิดพลาดระหว่างส่งข้อมูลโปรดลองใหม่อีกครั้ง", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: { 
                        self.present(textAlert, animated: true, completion: nil)
                        
                    })
                    
                }
                
            })
            
        }))
        
        self.present(textAlert, animated: true, completion: nil)
        
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
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        super.viewDidAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)

//        statusBarHidden = false
//        self.setNeedsStatusBarAppearanceUpdate()
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
                
                    itvCell.bannerImage.imageFromServerURL(urlString: url)
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
//                    
//                    let timeFormatter = DateFormatter()
//                    let dateFormatter = DateFormatter()
//                    
//                    dateFormatter.dateFormat = "dd มีนาคม"
//                    timeFormatter.dateFormat = "HH.mm"
                    if let start = start{
                        if let end = end{
                            let date = start.toThaiTextOnlyDate(withEnd: end)
                            let timeFormatter = DateFormatter()
                            timeFormatter.dateFormat = "HH.mm"
                            
                            let sTime = timeFormatter.string(from: start)
                            let eTime = timeFormatter.string(from: end)
                            dates.append(date)
                            times[date] = [String]()
                            times[date]?.append("\(sTime)-\(eTime)")
                            dateTimeList.append("\(date) \(sTime)-\(eTime)")
                        }
                    }
                   

//                    
//                    if !dates.contains(date) {
//                        
//                        dates.append(date)
//                        times[date] = [String]()
//                        
//                    }
//                    
//                    times[date]?.append("\(sTime)-\(eTime)")
//                    
//                    dateTimeList.append("\(date) \(sTime)-\(eTime)")                    
                    
                    for round in roundsObj {
                    
                        let timeFormatter = DateFormatter()
                        let dateFormatter = DateFormatter()
                        
                        dateFormatter.dateFormat = "  d มีนาคม"
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
                    
                    let room = RoomData.getRoomName(fromRoomId: self.room!, inManageobjectcontext: self.managedObjectContext!)
                    
                    let place = PlaceData.getPlaceName(fromPlaceId: self.place!, inManageobjectcontext: self.managedObjectContext!)
                    
                    let zoneName = ZoneData.getZoneName(fromZoneId: self.zoneId!, inManageobjectcontext: managedObjectContext!)
                    
                    
                    locationDesc = "\(room) \(place) \(zoneName)"
                
                    ehvc.topic = self.topic
                    ehvc.locationDesc = self.locationDesc
                    ehvc.dates = self.dates
                    ehvc.times = self.times
//                    ehvc.timeDesc = self.timeDesc
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
                    
                    if let url = image.url{
                        
                        images.append(url)
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
            
            return UITableViewAutomaticDimension
            
        } else if indexPath.row == 1 {
            
            return UITableViewAutomaticDimension
//            return DescTableViewCell.descCellHeight
            
        } else if indexPath.row == 2 {
            
            if pdf == ""{
                return 0
            }
            
            return 62
            
        } else if indexPath.row == 3 {
            
            if images.count == 0{
                return 0
            }
            
            return 71
            
        } else if indexPath.row == 4 {
            
            return 230
            
        } else {
            
            return 45
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "presentGallery" {
            
            if let destination = segue.destination as? GalleryViewController{
                
                destination.images = images
                
                if let cell = sender as? UICollectionViewCell{
                    
                    destination.currentImageIndex = cell.backgroundView!.tag
                }
            }
            
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
