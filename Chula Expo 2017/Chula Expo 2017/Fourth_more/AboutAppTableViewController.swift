//
//  AboutAppTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 3/12/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import Answers


class AboutAppTableViewController: UITableViewController {
    
    var datas = [data]()
    
    struct data {
        var thumb: UIImage = #imageLiteral(resourceName: "defaultImage")
        var headtext: String = ""
        var descText: String = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Answers.logContentView(withName: "About Application",
                               contentType: nil,
                               contentId: nil,
                               customAttributes: nil)
        
        prepareData()
        tableView.estimatedRowHeight = 200
        title = "About Application"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return datas.count + 2
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.row < datas.count{
            cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath)
            
            if let aboutCell = cell as? AboutAppTableViewCell{
                aboutCell.imageThumb = datas[indexPath.row].thumb
                aboutCell.head = datas[indexPath.row].headtext
                aboutCell.desc = datas[indexPath.row].descText
            }
        }
        else if indexPath.row == datas.count{
            cell = tableView.dequeueReusableCell(withIdentifier: "supportCell", for: indexPath)
            cell.viewWithTag(3)?.cardStyle(background: cell.viewWithTag(3)!)
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "sponCell", for: indexPath)
            cell.viewWithTag(3)?.cardStyle(background: cell.viewWithTag(3)!)
        }
        
        
        // Configure the cell...
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func prepareData(){
        datas = [
            data(thumb: #imageLiteral(resourceName: "ico-design"), headtext: "Application Designer", descText: "Nutthawat Pradujdecha (CP41)"),
            data(thumb: #imageLiteral(resourceName: "ico-ios"), headtext: "Application Developer", descText: "Pakpoom Thaweesitthichat (CP41)\nPanupong Tongtawach (CP41)\nThanapon Sirisompark (CP41)\nEkkalak Leelasornchai (CP42)"),
            data(thumb: #imageLiteral(resourceName: "ico-ios"), headtext: "Other Platform Developer", descText: "Sirinthra Chantharaj (CP41)\nNutthaphol Rakratchatakul (CP41)\nSupakrit Paoliwat (CP41)\nTeerapat Prompunjai (CP42))"),
            data(thumb: #imageLiteral(resourceName: "ico-backend"), headtext: "Back-end Developer", descText: "Atikhun Orisoon (CP40)\nApiruj Choomwattana (CP41)\nKitipong Sirirueangsakul (CP41)\nNuttapat Kirawittaya (CP41)\nPongsathorn Chotipanvidhayakul (CP41)\nPuttiphat Sriratpinyo (CP41)\nWasin Watthanasrisong (CP41)"),
            data(thumb: #imageLiteral(resourceName: "ico-recommendation"), headtext: "Recommendation System", descText: "Asst.Prof. Dr.Natawut Nupairoj"),
            data(thumb: #imageLiteral(resourceName: "ico-indoor"), headtext: "Indoor Localization System", descText: "Assc.Prof. Dr.Kultida Rojviboonchai\nTeerapat Vongsuteera (CP39)"),
            data(thumb: #imageLiteral(resourceName: "ico-advisor"), headtext: "Project Advisor", descText: "Asst.Prof. Dr.Athasit Surarerks"),
            data(thumb: #imageLiteral(resourceName: "ico-monitor"), headtext: "Project Monitoring", descText: "Krit Gangwanpongpun (CP40)\nTananan Tangthanachaikul (CP40)"),
            data(thumb: #imageLiteral(resourceName: "ico-sponsor"), headtext: "Project Sponsor", descText: "Chonpeeti Pornrungroj\nKrit Pattarawongvisut\nNarut Wasoontaramas")
        ]
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
