//
//  EventSelectViewController.swift
//  Chula Expo 2017
//
//  Created by NOT on 2/7/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class EventSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var selectedSection = 1
    
    struct cityData {
        var name: String = ""
        var bgImage: String = ""
        var iconImage: String = ""
        
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cityCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "facultyCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "interestCell")
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        setupCityData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
                cityCell.sub = "200 events"
                cityCell.tagname = "SMART"
            }
        }
        else if selectedSection == 2 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facultyCell", for: indexPath)
            if let facultyCell = cell as? FacultyCollectionViewCell{
                
            }
        }
        else {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath)
            if let interestCell = cell as? InterCollectionViewCell{
                
            }
        }
       
        
        // Configure the cell
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setupCityData(){
        cityDatas = [
            cityData(name: "Smart City", bgImage: "", iconImage: ""),
            cityData(name: "Health City", bgImage: "", iconImage: ""),
            cityData(name: "Human City", bgImage: "", iconImage: ""),
            cityData(name: "Sala Phrakeaw", bgImage: "", iconImage: ""),
            cityData(name: "Art Gallery", bgImage: "", iconImage: "")
        ]
    }
}
