//
//  interestCollectionViewController1.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 1/29/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class interestCollectionViewController1: UICollectionViewController {

    var tapped = [UIImageView]()
    
    struct tag {
        var imgName: String = ""
        var tagName: String = ""
        var tagBack: String = ""
        var tagEngName: String = ""
    }
    
    var tagList : [tag] = [
        tag(imgName: "heartIcon",  tagName: "พระราชกรณียกิจ",  tagBack: "technology",  tagEngName: "Royal Duties"),
        tag(imgName: "heartIcon",  tagName: "ไทยแลนด์ 4.0",  tagBack: "technology",  tagEngName: "Thailand 4.0"),
        tag(imgName: "heartIcon",  tagName: "พลังงาน",  tagBack: "technology",  tagEngName: "Energy"),
        tag(imgName: "heartIcon",  tagName: "สิ่งประดิษฐ์",  tagBack: "technology",  tagEngName: "Invention"),
        tag(imgName: "heartIcon",  tagName: "การออกแบบ",  tagBack: "technology",  tagEngName: "Design"),
        tag(imgName: "heartIcon",  tagName: "ไอที",  tagBack: "technology",  tagEngName: "IT"),
        tag(imgName: "heartIcon",  tagName: "การแพทย์",  tagBack: "technology",  tagEngName: "Medication"),
        tag(imgName: "heartIcon",  tagName: "ร่างกาย",  tagBack: "technology",  tagEngName: "Body"),
        tag(imgName: "heartIcon",  tagName: "จิตใจ",  tagBack: "technology",  tagEngName: "Mind"),
        tag(imgName: "heartIcon",  tagName: "สิ่งแวดล้อม",  tagBack: "technology",  tagEngName: "Environment"),
        tag(imgName: "heartIcon",  tagName: "สัตว์และพันธุ์พืช",  tagBack: "technology",  tagEngName: "Life"),
        tag(imgName: "heartIcon",  tagName: "อาหารและน้ำ",  tagBack: "technology",  tagEngName: "Food & Water"),
        tag(imgName: "heartIcon",  tagName: "ความงาม",  tagBack: "technology",  tagEngName: "Beauty"),
        tag(imgName: "heartIcon",  tagName: "คุณภาพชีวิต",  tagBack: "technology",  tagEngName: "Quality of Life"),
        tag(imgName: "heartIcon",  tagName: "สังคมผู้สูงอายุ",  tagBack: "technology",  tagEngName: "Aging Society"),
        tag(imgName: "heartIcon",  tagName: "เศรษฐกิจ",  tagBack: "technology",  tagEngName: "Economy"),
        tag(imgName: "heartIcon",  tagName: "ชุมชน",  tagBack: "technology",  tagEngName: "Community"),
        tag(imgName: "heartIcon",  tagName: "ปัญหาสังคม",  tagBack: "technology",  tagEngName: "Social Issues"),
        tag(imgName: "heartIcon",  tagName: "การศึกษา",  tagBack: "technology",  tagEngName: "Education"),
        tag(imgName: "heartIcon",  tagName: "การสื่อสาร",  tagBack: "technology",  tagEngName: "Communication"),
        tag(imgName: "heartIcon",  tagName: "การขนส่ง",  tagBack: "technology",  tagEngName: "Transportation"),
        tag(imgName: "heartIcon",  tagName: "ภูมิปัญญาไทย",  tagBack: "technology",  tagEngName: "Thai"),
        tag(imgName: "heartIcon",  tagName: "ศิลปวัฒนธรรม",  tagBack: "technology",  tagEngName: "Art & Culture"),
        tag(imgName: "heartIcon",  tagName: "กฎหมาย",  tagBack: "technology",  tagEngName: "Law")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
         layout.itemSize = CGSize(width: (self.view.frame.width-42.5)/2, height: 100)
         layout.minimumInteritemSpacing = 2.5
         layout.minimumLineSpacing = 2.5
         collectionView!.collectionViewLayout = layout
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tagList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell1", for: indexPath)
        
        // Configure the cell
        if let interestCell = cell as? interestCollectionViewCell1 {
            
            if tagList.count > (indexPath.row) {
                interestCell.imgName[0] = tagList[(indexPath.row)].imgName
                interestCell.tagName[0] = tagList[(indexPath.row)].tagName
                interestCell.tagBack[0] = tagList[(indexPath.row)].tagBack
                interestCell.tagEngName[0] = tagList[(indexPath.row)].tagEngName
            }else{
                interestCell.tagName[0] = ""
            }
        }
        //cell.backgroundColor = UIColor.black
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */

}