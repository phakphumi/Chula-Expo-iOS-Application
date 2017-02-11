//
//  interestFacityViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit

class interestFacityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var tapped = [UIImageView]()
    @IBOutlet weak var finButton2: UIButton! {
        didSet{
            roundedCornerBack1()
        }
    }
    func roundedCornerBack1()
    {
        finButton2.layer.cornerRadius = 3
        finButton2.layer.masksToBounds = true
        
    }
    struct tag {
        var imgName: String = ""
        var tagName: String = ""
        var tagBack: String = ""
        var tagEngName: String = ""
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var tagList : [tag] = [
        tag(imgName: "heartIcon",  tagName: "ครุศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Education"),
        tag(imgName: "heartIcon",  tagName: "จิตวิทยา",  tagBack: "technology",  tagEngName: "Faculty of Psychology"),
        tag(imgName: "heartIcon",  tagName: "ทันตแพทยศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Dentistry"),
        tag(imgName: "heartIcon",  tagName: "นิติศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Law"),
        tag(imgName: "heartIcon",  tagName: "นิเทศศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Communication Arts"),
        tag(imgName: "heartIcon",  tagName: "พยาบาลศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Nursing"),
        tag(imgName: "heartIcon",  tagName: "พาณิชยศาสตร์และการบัญชี",  tagBack: "technology",  tagEngName: "Faculty of Commerce and Accountancy"),
        tag(imgName: "heartIcon",  tagName: "รัฐศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Political Science"),
        tag(imgName: "heartIcon",  tagName: "วิทยาศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Science"),
        tag(imgName: "heartIcon",  tagName: "วิทยาศาสตร์การกีฬา",  tagBack: "technology",  tagEngName: "Faculty of Sports Science"),
        tag(imgName: "heartIcon",  tagName: "วิศวกรรมศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Engineering"),
        tag(imgName: "heartIcon",  tagName: "ศิลปกรรมศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Fine and Applied Arts"),
        tag(imgName: "heartIcon",  tagName: "สถาปัตยกรรมศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Architecture"),
        tag(imgName: "heartIcon",  tagName: "สหเวชศาสตร์",  tagBack: "technology",  tagEngName: "aculty of Allied Health Sciences"),
        tag(imgName: "heartIcon",  tagName: "สัตวแพทยศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Veterinary Science"),
        tag(imgName: "heartIcon",  tagName: "อักษรศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Arts"),
        tag(imgName: "heartIcon",  tagName: "เภสัชศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Pharmaceutical Sciences"),
        tag(imgName: "heartIcon",  tagName: "เศรษฐศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Economic"),
        tag(imgName: "heartIcon",  tagName: "แพทยศาสตร์",  tagBack: "technology",  tagEngName: "Faculty of Medicine"),
        tag(imgName: "heartIcon",  tagName: "สำนักวิชาทรัพยากรการเกษตร",  tagBack: "technology",  tagEngName: "School of Agricultural"),
        tag(imgName: "heartIcon",  tagName: "บัณฑิตวิทยาลัย",  tagBack: "technology",  tagEngName: "Graduate School"),
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 20, right: 30)
         layout.itemSize = CGSize(width: (self.view.frame.width-50)/2, height: 100)
         layout.minimumInteritemSpacing = 2.5
         layout.minimumLineSpacing = 2.5
         collectionView!.collectionViewLayout = layout
        /*
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 20, right: 30)
        layout.itemSize = CGSize(width: (self.view.frame.width-65)/3, height: (self.view.frame.width-65)/3)
        layout.minimumInteritemSpacing = 2.5
        layout.minimumLineSpacing = 2.5
        collectionView!.collectionViewLayout = layout
        */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
