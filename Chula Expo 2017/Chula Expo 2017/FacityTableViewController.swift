//
//  FacityTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 1/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData
class FacityTableViewController: UITableViewController
{
    struct facity
    {
        var name: String = ""
        var logoName: String = ""
    }
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    var facityList : [Array<facity>] =
    [
        [facity(name: "Smart City",     logoName: "smartLogo")
        ,facity(name: "Health City",    logoName: "smartLogo")
        ,facity(name: "Human City",     logoName: "smartLogo")
        ],
        [facity(name: "Faculty of Engineering",         logoName: "smartLogo")
        ,facity(name: "Faculty of Arts",                logoName: "smartLogo")
        ,facity(name: "Faculty of Science",             logoName: "smartLogo")
        ,facity(name: "Faculty of Political Science",   logoName: "smartLogo")
        ,facity(name: "Faculty of Architecture",        logoName: "smartLogo")
        ,facity(name: "Faculty of Commerce and Accountancy", logoName: "smartLogo")
        ,facity(name: "Faculty of Education",           logoName: "smartLogo")
        ,facity(name: "Faculty of Communication Arts",  logoName: "smartLogo")
        ,facity(name: "Faculty of Economics",           logoName: "smartLogo")
        ,facity(name: "Faculty of Medicine",            logoName: "smartLogo")
        ,facity(name: "Faculty of Veterinary Science",  logoName: "smartLogo")
        ,facity(name: "Faculty of Dentistry",           logoName: "smartLogo")
        ,facity(name: "Faculty of Pharmaceutical Science", logoName: "smartLogo")
        ,facity(name: "Faculty of Law",                 logoName: "smartLogo")
        ,facity(name: "Faculty of Fine and Applied Arts", logoName: "smartLogo")
        ,facity(name: "Faculty of Allied Health Sciences", logoName: "smartLogo")
        ,facity(name: "Faculty of Psychology",          logoName: "smartLogo")
        ,facity(name: "Faculty of Sports Sciece",       logoName: "smartLogo")
        ,facity(name: "Faculty of Agricultural Resources", logoName: "smartLogo")
        ]
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Events"
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        updateDatabase()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateDatabase()
    {
        managedObjectContext?.perform
        {
           
            _ = EventData.addData(
                name: "Test",
                facity: "Smart City",
                locationDesc: "308 ENG3 Building",
                startTime: NSDate(timeIntervalSinceNow: 1000),
                endTime: NSDate(timeIntervalSinceNow: 3000),
                shortDesc: "", longDesc: "",
                canReserve: true,
                numOfSeat: 99,
                inManageobjectcontext: self.managedObjectContext!
            )
        }
        do
        {
            try self.managedObjectContext?.save()
            print("saved")
        }
        catch let error {
            print("saveError with \(error)")
        }
        printDatabaseStatistics()
    }
    
    private func printDatabaseStatistics()
    {
        managedObjectContext?.perform {
            if let result = try? self.managedObjectContext!.fetch(NSFetchRequest(entityName: "EventData")){
                print("Total datas in coredata \(result.count)")
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0{
            return 1
        }
        else{
            return facityList[section-1].count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell
        
        if indexPath.row == 0 && indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
            cell.selectionStyle = .none
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "facityCell", for: indexPath)
            
            if let facityCell = cell as? FacityTableViewCell
            {
                facityCell.name = facityList[indexPath.section-1][indexPath.row].name
                facityCell.logo = facityList[indexPath.section-1][indexPath.row].logoName
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0){
            return nil
        }
        if (section == 1){
            return "CITY"
        }
        if (section == 2){
            return "FACULTY"
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectFacity"{
            print ("select facity ")
            print ( (sender as? FacityTableViewCell)?.name ?? "nil")
            if let dest = segue.destination as? EventsTableViewController{
                dest.facity = (sender as? FacityTableViewCell)?.name
                dest.managedObjectContext = managedObjectContext
            }
            segue.destination.title = (sender as? FacityTableViewCell)?.name
        }
    }
    
}
