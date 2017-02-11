//
//  EventSelectViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/7/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

class EventSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var topTab: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var selectedSection = 1
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    
    struct cityData {
        var name: String = ""
        var bgImage: String = ""
        var iconImage: String = ""
        var tagName: String?
        var tagColor: UIColor = UIColor.clear
        
    }
    struct facultyData {
        var name: String = ""
        var bgImage: String = ""
        var iconImage: String = ""
        
    }
    struct interestData {
        var name: String = ""
        var bgImage: String = ""
        var iconImage: String = ""
        
    }
    var cityDatas: [cityData] = []
    var facultyDatas: [facultyData] = []
    var interestDatas: [interestData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        let shadowPath = UIBezierPath(rect: topTab.bounds)
        topTab.layer.shadowColor = UIColor.darkGray.cgColor
        topTab.layer.shadowOffset = CGSize(width: 0, height: 0)
        topTab.layer.shadowRadius = 1
        topTab.layer.shadowOpacity = 0.5
        topTab.layer.shadowPath = shadowPath.cgPath

        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cityCell")
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "facultyCell")
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "interestCell")
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        setupCityData()
        let layout = CityLayout()
        collectionView.collectionViewLayout = layout

//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 35, bottom: 20, right: 35)
//        layout.itemSize = CGSize(width: (self.view.frame.width-60)/2, height: 100)
//        layout.minimumInteritemSpacing = 2.5
//        layout.minimumLineSpacing = 2.5
//        collectionView.collectionViewLayout = layout
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("numofsection   \(cityDatas.count)")
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch selectedSection {
        case 1:
            return cityDatas.count
        case 2:
            return facultyDatas.count
        case 3:
            return interestDatas.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if selectedSection == 1 {
            
            print ("section 1")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath)
            if let cityCell = cell as? CityCollectionViewCell{
                cityCell.name = cityDatas[indexPath.row].name
                cityCell.bg = cityDatas[indexPath.row].bgImage
                cityCell.icon = cityDatas[indexPath.row].iconImage
                cityCell.sub = "200 Events"
                cityCell.tagname = cityDatas[indexPath.row].tagName
                cityCell.tagColor = cityDatas[indexPath.row].tagColor
            }
        }
        else if selectedSection == 2 {
            print ("section 2")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facultyCell", for: indexPath)
            if let facultyCell = cell as? FacultyCollectionViewCell{
                
            }
        }
        else {
            print ("section else")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath)
            if let interestCell = cell as? InterCollectionViewCell{
                
            }
        }
       
        
        // Configure the cell
        
        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectFacity"{
            if let dest = segue.destination as? EventsTableViewController{
//                dest.facity = (sender as? FacityTableViewCell)?.name
                dest.facity = "5899a98a5eeecd3698f6cfc6"
                dest.managedObjectContext = managedObjectContext
            }
            segue.destination.title = (sender as? CityCollectionViewCell)?.name
        }
    }
    func setupCityData(){
        cityDatas = [
            cityData(name: "Smart City", bgImage: "smartBG", iconImage: "smartICON", tagName: "SMART", tagColor: UIColor(red:1.00, green:0.45, blue:0.00, alpha:1.0)),
            cityData(name: "Health City", bgImage: "healthBG", iconImage: "healthICON", tagName: "HEALTH", tagColor: UIColor(red:0.24, green:0.68, blue:0.20, alpha:1.0)),
            cityData(name: "Human City", bgImage: "humanBG", iconImage: "humanICON", tagName: "HUMAN", tagColor: UIColor(red:0.40, green:0.18, blue:0.57, alpha:1.0)),
            cityData(name: "Sala Phrakeaw", bgImage: "salaBG", iconImage: "salaICON", tagName: nil, tagColor: UIColor.clear),
            cityData(name: "Art Gallery", bgImage: "artBG", iconImage: "artICON", tagName: nil, tagColor: UIColor.clear)
        ]
    }
}
