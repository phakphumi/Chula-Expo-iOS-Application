//
//  StageExpandTableViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/1/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class StageExpandTableViewController: StageExpandableCoreDataTableViewController {
    
    @IBOutlet weak var topTab: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!

    
    var selectionIndicatorView: UIView = UIView()
    var selectedDate: Int = 1
    var stageNo: Int? {
        
        didSet {
            
            updateUI()
        }
    }
    var managedObjectContext: NSManagedObjectContext? {
        
        didSet {
            
            updateUI()
        }
    }
    
    var selectSection: Int?{
        
        didSet{
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    func setupTopTab(){
        
        moveToptabIndicator()
        let shadowPath = UIBezierPath(rect: topTab.bounds)
        topTab.layer.shadowColor = UIColor.darkGray.cgColor
        topTab.layer.shadowOffset = CGSize(width: 0, height: 0)
        topTab.layer.shadowRadius = 1
        topTab.layer.shadowOpacity = 0.5
        topTab.layer.shadowPath = shadowPath.cgPath
        updateButton(no: selectedDate, toBlack: false)
        
    }
    
    @IBAction func selectDate(_ sender: Any) {
        
        if let button = sender as? UIButton{
            updateButton(no: selectedDate, toBlack: true)
            selectedDate = button.tag
            updateButton(no: selectedDate, toBlack: false)
        }
        moveToptabIndicator()
    }
    
    func changeButtonAttributeColor(_ color: UIColor,for button: UIButton){
        
        let attribute = NSMutableAttributedString(attributedString: button.currentAttributedTitle!)
        attribute.addAttribute(NSForegroundColorAttributeName , value: color, range: NSRange(location: 0,length: 6))
        button.setAttributedTitle(attribute, for: .normal)
        button.setAttributedTitle(attribute, for: .highlighted)
    }

    func moveToptabIndicator(){
        
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            let sectionWidth = self.topTab.frame.width / 5
            let sectionX = (sectionWidth * (CGFloat)(self.selectedDate - 1) ) + 2
            self.selectionIndicatorView.frame = CGRect(x: sectionX, y: self.topTab.bounds.height-2, width: sectionWidth-4, height: 2)
        })
    }
    
    func updateButton(no: Int,toBlack: Bool){
        
        var color: UIColor
        var button: UIButton
        if toBlack{
            color = UIColor.black
        } else {
            color = UIColor(red:1.00, green:0.43, blue:0.60, alpha:1.0)
        }
        switch no {
        case 1:
            button = button1
        case 2:
            button = button2
        case 3:
            button = button3
        case 4:
            button = button4
        case 5:
            button = button5
        default:
            button = button1
        }
        changeButtonAttributeColor(color, for: button)
    }
    
    fileprivate func updateUI(){
        if let context = managedObjectContext{
            if let stageNo = stageNo{
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
                request.predicate = NSPredicate(format: "stageNo == %i", stageNo)
                request.sortDescriptors = [NSSortDescriptor(
                    key: "name",
                    ascending: true
//                    selector: #selector(NSDate.compare(_:))
                    )]
                fetchedResultsController = NSFetchedResultsController(
                    fetchRequest: request,
                    managedObjectContext: context,
                    sectionNameKeyPath: "name",
                    cacheName: nil
                )
            }
            else{
                fetchedResultsController = nil
            }
        }
        else{
            fetchedResultsController = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        var selectionIndicatorFrame : CGRect = CGRect()
        let sectionWidth = topTab.frame.width / 5
        selectionIndicatorFrame = CGRect(x: (sectionWidth * (CGFloat)(selectedDate - 1) ) + 2 , y: topTab.bounds.height-2, width: sectionWidth - 4, height: 2)
        selectionIndicatorView = UIView(frame: selectionIndicatorFrame)
        selectionIndicatorView.backgroundColor = UIColor(red:1.00, green:0.43, blue:0.60, alpha:1.0)
        setupTopTab()
        topTab.addSubview(selectionIndicatorView)
        tableView.estimatedRowHeight = 140
        tableView.reloadData()
//        tableView.contentInset = UIEdgeInsetsMake(((self.navigationController?.navigationBar.frame)?.height)! + (self.navigationController?.navigationBar.frame)!.origin.y, 0.0,  ((self.tabBarController?.tabBar.frame)?.height)!, 0);
        // Uncomment the following line to preserve selection between presentations
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
//        self.tableView.backgroundColor = UIColor.blue
        print("loadedStage")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("layoutStage")
        setupTopTab()
    }

    
        // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if indexPath.row == 0{

            cell = tableView.dequeueReusableCell(withIdentifier: "StageEventCell", for: indexPath)
            if let fetchData = fetchedResultsController?.object(at: IndexPath(row: 0, section: indexPath.section)) as? ActivityData{
                    
                var name: String?
                fetchData.managedObjectContext?.performAndWait {
                    
                    name = fetchData.name
                }

                if let stageExpandableCell = cell as? StageExpandableCell{
                    
                    stageExpandableCell.name = name
                    stageExpandableCell.time = "9:41"
                }
            }
        }
        
        else{
                
            cell = tableView.dequeueReusableCell(withIdentifier: "stageDetail", for: indexPath)
            
            if let fetchData = fetchedResultsController?.object(at: IndexPath(row: 0, section: indexPath.section)) as? ActivityData{
                
                var desc: String?
                fetchData.managedObjectContext?.performAndWait {
                    
                    desc = fetchData.desc
                }
                
                if let stageDetailCell = cell as? StageDetailCell{
                    
                    stageDetailCell.desc = desc
                }
            }
        }
        

        // Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectSection == indexPath.section && indexPath.row == 0{
            selectSection = nil
        }
        else{
            selectSection = indexPath.section
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 50
        }else  if indexPath.row == 1 && indexPath.section == selectSection{
            return 170
        }
        return 0;
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 }
