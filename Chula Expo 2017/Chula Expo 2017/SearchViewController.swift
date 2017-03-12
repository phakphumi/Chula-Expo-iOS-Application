//
//  SearchViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/3/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.

import UIKit
import CoreData
import CoreLocation
import MapKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate, CLLocationManagerDelegate {

    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var Events = [ActivityData]()
    let searchController = UISearchController(searchResultsController: nil)
    let locationManager = CLLocationManager()
    
    var ShouldShowResult = false
    var fetchActivity = [ActivityData]()

    //@IBOutlet var tableHeader: TableHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        requestForSearchFeedEvent()
        requestForNearByEvent()

//        for subView in self.searchBar.subviews
//        {
//            for subsubView in subView.subviews
//            {
//                if let textField = subsubView as? UITextField
//                {
//                    textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search", comment: ""), attributes: [NSForegroundColorAttributeName: UIColor.red])
//                    textField.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                    textField.textColor = UIColor(red:1.00, green:0.42, blue:0.60, alpha:1.0)
//                }
//            }
//        }
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        tableView.estimatedRowHeight = 150
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        ShouldShowResult = true
        self.tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let fetchNearbyData = NSFetchRequest<NSFetchRequestResult>(entityName: "NearbyActivity")
        let requestDeleteNearbyData = NSBatchDeleteRequest(fetchRequest: fetchNearbyData)
        do{
            
            try managedObjectContext!.execute(requestDeleteNearbyData)
            
        } catch let error {
            
            print(error)
            
        }

        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        
        APIController.downloadNearbyActivities(fromLatitude: locValue.latitude, longitude: locValue.longitude, inManageobjectcontext: managedObjectContext!, completion: nil)
        
        APIController.getWhereAmI(latitude: locValue.latitude, longitude: locValue.longitude, inManageobjectcontext: managedObjectContext!, completion: { (zone) in
            
            if let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? MapSearchTableViewCell{
                print("\(locValue.latitude) , \(locValue.latitude)")
                cell.locationDesc = "คุณอยู่ที่\(zone?["th"] ?? "\'ไม่พบข้อมูล\'")"
                cell.map.setRegion(region, animated: true)
                cell.map.showsUserLocation = true
                cell.map.showsCompass = false
            }
        })
        locationManager.stopUpdatingLocation()
        tableView.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = nil
        searchBar.showsCancelButton = false
        ShouldShowResult = false
        self.tableView.reloadData()
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        
        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            do {
                if let frc = fetchedResultsController {
                    frc.delegate = self
                    try frc.performFetch()
                }
                tableView.reloadData()
            } catch let error {
                print("NSFetchedResultsController.performFetch() failed: \(error)")
            }
        }
    }
    
    var fetchedResultsController2: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            do {
                if let frc = fetchedResultsController2 {
                    frc.delegate = self
                    try frc.performFetch()
                }
                tableView.reloadData()
            } catch let error {
                print("NSFetchedResultsController2.performFetch() failed: \(error)")
            }
        }
    }

    func requestForSearchFeedEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecommendActivity")
        request.sortDescriptors = [NSSortDescriptor(
            key: "toActivity.activityId",
            ascending: true
            )]
        if let context = managedObjectContext {
            
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        }
    }
    
    func requestForNearByEvent(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NearbyActivity")
        request.sortDescriptors = [NSSortDescriptor(
            key: "toActivity.activityId",
            ascending: true
            )]
        if let context = managedObjectContext {
            
            fetchedResultsController2 = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        managedObjectContext?.performAndWait {
            
            self.fetchActivity = ActivityData.fetchActivityFromSearch(name: searchText, inManageobjectcontext: self.managedObjectContext!)
        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        tableView.reloadData()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        if(ShouldShowResult) {
            
            return 1
        }
        else {
            
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(ShouldShowResult) {
            
            return fetchActivity.count
        }
        else{
            if(section == 0){
                
                if let i = (fetchedResultsController2?.sections?[0])?.numberOfObjects{
                    return i+2
                }
            }
            else{
                
                if let i = (fetchedResultsController?.sections?[0])?.numberOfObjects{
                    return i+1
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if(ShouldShowResult) {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "EventSearchFeed", for: indexPath)
            
            if let eventFeedCell = cell as? EventFeedCell{

                eventFeedCell.manageObjectContext = managedObjectContext
                eventFeedCell.name = fetchActivity[indexPath.row].name
                eventFeedCell.thumbnail = fetchActivity[indexPath.row].thumbnailsUrl
                eventFeedCell.facity = fetchActivity[indexPath.row].faculty
                eventFeedCell.activityId = fetchActivity[indexPath.row].activityId
                
                var time: String?
                if let stime = fetchActivity[indexPath.row].start{
                    if let eTime = fetchActivity[indexPath.row].end{
                        time = stime.toThaiText(withEnd: eTime)
                    }
                }
                if let toRound = fetchActivity[indexPath.row].toRound{
                    if time != nil{
                        if toRound.count > 0 {
                            time = ("\(time!) + \(toRound.count) รอบ")
                        }
                    }
                }

                eventFeedCell.timeText = time
                eventFeedCell.eventTumbnailImage.image = #imageLiteral(resourceName: "defaultImage")
                eventFeedCell.toRound = fetchActivity[indexPath.row].toRound
                
            }
        }
        else {

            if indexPath.section == 0 && indexPath.row == 0 {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSearch", for: indexPath)
                if let headerCell = cell as? HeaderSearchTableViewCell{
                    headerCell.title1 = "WHERE AM I ?"
                    headerCell.title2 = "แนะนำ Events จากสถานที่ปัจจุบันของคุณ"
                    headerCell.iconImage = "location-mark"
                }
                cell.selectionStyle = .none
                
            }
            
            else if indexPath.section == 0 && indexPath.row == 1 {
                // ForJoe
                cell = tableView.dequeueReusableCell(withIdentifier: "Map", for: indexPath)
                if let mapCell = cell as? MapSearchTableViewCell{
//                    mapCell.map
//                    mapCell.locationDesc
                }
            }

            else if indexPath.section == 1 && indexPath.row == 0 {

                    cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSearch", for: indexPath)
                    if let headerCell = cell as? HeaderSearchTableViewCell{
                        headerCell.title1 = "EVENT FOR YOU"
                        headerCell.title2 = "แนะนำกิจกรรมที่คุณอาจสนใจ"
                        headerCell.iconImage = "heartIcon"
                    }
                    cell.selectionStyle = .none
            }

            else {

                cell = tableView.dequeueReusableCell(withIdentifier: "EventSearchFeed", for: indexPath)

                var name: String?
                var thumbnail: String?
                var toRound: NSSet?
                var facity: String?
                var activityId: String?
                var time: String?

                if indexPath.section == 0{
                    
                    if let fetchData = (fetchedResultsController2?.object(at: IndexPath(row: indexPath.row-2, section: 0)) as? NearbyActivity)?.toActivity {
                        
                        fetchData.managedObjectContext?.performAndWait{
                            name = fetchData.name
                            thumbnail = fetchData.thumbnailsUrl
                            facity = fetchData.faculty
                            toRound = fetchData.toRound
                            activityId = fetchData.activityId
                            if let stime = fetchData.start{
                                if let eTime = fetchData.end{
                                    time = stime.toThaiText(withEnd: eTime)
                                }
                            }
                            if let toRound = toRound{
                                if time != nil{
                                    if toRound.count > 0 {
                                        time = ("\(time!) + \(toRound.count) รอบ")
                                    }
                                }
                            }
                        }
                    }
                }
                    
                else if indexPath.section == 1{
                    
                    if let fetchData = (fetchedResultsController?.object(at: IndexPath(row: indexPath.row-1, section: 0)) as? RecommendActivity)?.toActivity {
                        fetchData.managedObjectContext?.performAndWait{
                            name = fetchData.name
                            thumbnail = fetchData.thumbnailsUrl
                            facity = fetchData.faculty
                            toRound = fetchData.toRound
                            activityId = fetchData.activityId
                            if let stime = fetchData.start{
                                if let eTime = fetchData.end{
                                    time = stime.toThaiText(withEnd: eTime)
                                }
                            }
                            if let toRound = toRound{
                                if time != nil{
                                    if toRound.count > 0 {
                                        time = ("\(time!) + \(toRound.count) รอบ")
                                    }
                                }
                            }
                        }
                    }
                }
                
                if let eventFeedCell = cell as? EventFeedCell{
                    
                    eventFeedCell.manageObjectContext = managedObjectContext
                    
                    if name != nil{
                        eventFeedCell.name = name
                    }
                    
                    if time != nil{
                        eventFeedCell.timeText = time
                    }
                    
                    eventFeedCell.eventTumbnailImage.image = #imageLiteral(resourceName: "defaultImage")
                    eventFeedCell.thumbnail = thumbnail
                    eventFeedCell.facity = facity
                    eventFeedCell.activityId = activityId
                    eventFeedCell.toRound = toRound
                    
                }
            }
        }
        cell.selectionStyle = .none
        return cell
        
    }
    
    func searchButtonClicked(searchBar: UISearchBar){
        
        ShouldShowResult = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    

//     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if(!ShouldShowResult){
//            if section == 0 {
//                return 4
//            }
//        }
//            return 0
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(!ShouldShowResult){
            if section == 0{
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
                view.backgroundColor = UIColor.clear
                return view
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(!ShouldShowResult){
            
            if indexPath.row == 1 && indexPath.section == 0 {
                
                return UITableViewAutomaticDimension
            }
            else if indexPath.row == 0 {
                
                return 58
            }
            else {
                
                return 78
            }
            
        }
            
        else {
            
            return 78
        }
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEventDetails" {
            
            if let destination = segue.destination as? EventDetailTableViewController{
                
                if let eventcell = sender as? EventFeedCell?{
                    
                    if let id = eventcell?.activityId{
                        
                        ActivityData.fetchActivityData(activityId: id, inManageobjectcontext: managedObjectContext!, completion: { (activityData) in
                            
                            if let activityData = activityData {
                                
                                destination.activityId = activityData.activityId
                                destination.bannerUrl = activityData.bannerUrl
                                destination.topic = activityData.name
                                destination.locationDesc = ""
                                destination.toRounds = activityData.toRound
                                destination.desc = activityData.desc
                                destination.room = activityData.room
                                destination.place = activityData.place
                                destination.zoneId = activityData.faculty
                                destination.latitude = activityData.latitude
                                destination.longitude = activityData.longitude
                                destination.pdf = activityData.pdf
                                destination.toImages = activityData.toImages
                                destination.toTags = activityData.toTags
                                destination.start = activityData.start
                                destination.end = activityData.end
                                destination.managedObjectContext = self.managedObjectContext
                                
                            }
                            
                        })
                        
                    }
                }
            }
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        if controller == fetchedResultsController{
            
            switch type {
            case .insert: tableView.insertSections(IndexSet(integer: 1), with: .fade)
            case .delete: tableView.deleteSections(IndexSet(integer: 1), with: .fade)
            default: break
            }
            
        } else {
            
            switch type {
            case .insert: tableView.insertSections(IndexSet(integer: 0), with: .fade)
            case .delete: tableView.deleteSections(IndexSet(integer: 0), with: .fade)
            default: break
            }
            
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if controller == fetchedResultsController{
            var newIndex = IndexPath()
            var index = IndexPath()
            
            if newIndexPath != nil {
                newIndex = IndexPath(row: newIndexPath!.row+1, section: newIndexPath!.section + 1)
            }
            
            if indexPath != nil {
                index = IndexPath(row: indexPath!.row+1, section: indexPath!.section + 1)
            }
            
            switch type {
            case .insert:
                tableView.insertRows(at: [newIndex], with: .automatic)
            case .delete:
                print("delete")
                tableView.deleteRows(at: [index], with: .automatic)
            case .update:
                tableView.reloadRows(at: [index], with: .automatic)
            case .move:
                tableView.deleteRows(at: [index], with: .automatic)
                tableView.insertRows(at: [newIndex], with: .automatic)
            }
        }
        else{
            var newIndex = IndexPath()
            var index = IndexPath()
            
            if newIndexPath != nil {
                newIndex = IndexPath(row: newIndexPath!.row+2, section: newIndexPath!.section)
            }
            
            if indexPath != nil {
                index = IndexPath(row: indexPath!.row+2, section: indexPath!.section)
            }
            
            switch type {
            case .insert:
                tableView.insertRows(at: [newIndex], with: .automatic)
            case .delete:
                tableView.deleteRows(at: [index], with: .automatic)
            case .update:
                tableView.reloadRows(at: [index], with: .automatic)
            case .move:
                tableView.deleteRows(at: [index], with: .automatic)
                tableView.insertRows(at: [newIndex], with: .automatic)
            }

        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }


}

