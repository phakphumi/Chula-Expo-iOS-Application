//
//  interestViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/4/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class interestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    
    var userType: String!
    var name: String!
    var email: String!
    var age: String!
    var gender: String!
    var education: String!
    var educationYear: String!
    var school: String!
    var career: String!
    var fbId: String!
    var fbToken: String!
    var fbImageProfileUrl: String?
    var fbImage: UIImage!
    var managedObjectContext: NSManagedObjectContext?
    
    var selectedList: [Bool] = []
    var tapped = [UIImageView]()
    
    @IBOutlet var numberLabel: UILabel!
    
    @IBOutlet weak var finButton: UIButton! {
        didSet{
            roundedCornerBack1()
        }
    }
    func roundedCornerBack1()
    {
        finButton.layer.cornerRadius = 3
        finButton.layer.masksToBounds = true
        
    }
    struct tag {
        var imgName: String = ""
        var tagName: String = ""
        var tagBack: String = ""
        var tagEngName: String = ""
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
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
        for _ in 0...tagList.count{
            selectedList.append(false)
        }
        /* let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
         layout.itemSize = CGSize(width: (self.view.frame.width-42.5)/2, height: 100)
         layout.minimumInteritemSpacing = 2.5
         layout.minimumLineSpacing = 2.5
         collectionView!.collectionViewLayout = layout */
        
       
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 40, right: 30)
        layout.itemSize = CGSize(width: (self.view.frame.width-65)/3, height: (self.view.frame.width-65)/3)
        layout.minimumInteritemSpacing = 2.5
        layout.minimumLineSpacing = 2.5
        collectionView!.collectionViewLayout = layout
//        collectionView.allowsSelection = false
//        collectionView.isUserInteractionEnabled = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews() {
        
        numberLabel.layer.cornerRadius = numberLabel.frame.height / 2
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var check = false
        for i in 0...tagList.count {
            // print(selectedList[i])
            if selectedList[i] {
                check = true
            }
        }
        print(check)
        if(check == true){
        if segue.identifier == "toFaculty" {
            
            let destination = segue.destination as! interestFacityViewController
            
            destination.userType = self.userType
            destination.name = self.name
            destination.email = self.email
            destination.age = self.age
            destination.gender = self.gender
            destination.fbId = self.fbId
            destination.fbToken = self.fbToken
            destination.fbImageProfileUrl = self.fbImageProfileUrl!
            destination.fbImage = self.fbImage!
            destination.managedObjectContext = self.managedObjectContext
            
            
            if self.userType == "Academic" {
                
                destination.education = self.education
                destination.educationYear = self.educationYear
                destination.school = self.school
                destination.career = ""
                
            } else {
                
                destination.education = ""
                destination.educationYear = ""
                destination.school = ""
                destination.career = self.career
                
            }
            
            }
        }
    }
    
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
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        
        // Configure the cell
        if let cell = cell as? InterestCollectionViewCell {
            
            if tagList.count > (indexPath.row) {
                cell.imgName[0] = tagList[(indexPath.row)].imgName
                cell.tagName[0] = tagList[(indexPath.row)].tagName
                cell.tagBack[0] = tagList[(indexPath.row)].tagBack
                cell.tagEngName[0] = tagList[(indexPath.row)].tagEngName
                cell.didSelectCell = selectedList[indexPath.row]
                
    
            }else{
                cell.tagName[0] = ""
            }
            return cell
        }
        //cell.backgroundColor = UIColor.black
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedList[indexPath.row] == false {
            
            selectedList[indexPath.row] = true
        }
        else {
            
            selectedList[indexPath.row] = false
            
        }
        print("Selecr ", indexPath.row)
        if let cell = collectionView.cellForItem(at: indexPath) as? InterestCollectionViewCell{
            
            cell.didSelectCell = selectedList[indexPath.row]
            if selectedList[indexPath.row] {
            cell.backImg1.frame = CGRect(origin: CGPoint(x:cell.backImg1.frame.origin.x+1, y: cell.backImg1.frame.origin.y+1), size: CGSize(width: cell.backImg1.bounds.size.width-1,height: cell.backImg1.bounds.size.height-1))
            cell.engName1.frame = CGRect(origin: CGPoint(x:cell.engName1.frame.origin.x+1, y: cell.engName1.frame.origin.y+1), size: CGSize(width: cell.engName1.bounds.size.width-1,height: cell.engName1.bounds.size.height-1))
            cell.interestImg1.frame = CGRect(origin: CGPoint(x:cell.interestImg1.frame.origin.x+1, y: cell.interestImg1.frame.origin.y+1), size: CGSize(width: cell.interestImg1.bounds.size.width-1,height: cell.interestImg1.bounds.size.height-1))
            cell.interestName1.frame = CGRect(origin: CGPoint(x:cell.interestName1.frame.origin.x+1, y: cell.interestName1.frame.origin.y+1), size: CGSize(width: cell.interestName1.bounds.size.width-1,height: cell.interestName1.bounds.size.height-1))
            cell.interestView1.layer.borderColor = UIColor.green.cgColor
            cell.interestView1.layer.borderWidth = 3
            cell.interestName1.textColor = UIColor.green
            cell.engName1.textColor = UIColor.green
            }
            else {
                cell.backImg1.frame = CGRect(origin: CGPoint(x:cell.backImg1.frame.origin.x-1, y: cell.backImg1.frame.origin.y-1), size: CGSize(width: cell.backImg1.bounds.size.width+1,height: cell.backImg1.bounds.size.height+1))
                cell.engName1.frame = CGRect(origin: CGPoint(x:cell.engName1.frame.origin.x-1, y: cell.engName1.frame.origin.y-1), size: CGSize(width: cell.engName1.bounds.size.width+1,height: cell.engName1.bounds.size.height+1))
                cell.interestImg1.frame = CGRect(origin: CGPoint(x:cell.interestImg1.frame.origin.x-1, y: cell.interestImg1.frame.origin.y-1), size: CGSize(width: cell.interestImg1.bounds.size.width+1,height: cell.interestImg1.bounds.size.height+1))
                cell.interestName1.frame = CGRect(origin: CGPoint(x:cell.interestName1.frame.origin.x-1, y: cell.interestName1.frame.origin.y-1), size: CGSize(width: cell.interestName1.bounds.size.width+1,height: cell.interestName1.bounds.size.height+1))
                cell.interestView1.layer.borderColor = UIColor.white.cgColor
                cell.interestView1.layer.borderWidth = 0
                cell.interestName1.textColor = UIColor.white
                cell.engName1.textColor = UIColor.white
            }
         //   print("\(cell.didSelectCell)")
            
        }
    }

 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func next(_ sender: UIButton) {
        var check = false
        for i in 0...tagList.count {
           // print(selectedList[i])
            if selectedList[i] {
                check = true
            }
        }
        print(check)
        if(check == false){
            let button2Alert: UIAlertView = UIAlertView(title: "", message: "please select", delegate: self, cancelButtonTitle: "OK")
            button2Alert.show()
        }
        else {
            self.performSegue(withIdentifier: "toFaculty", sender: self)
        }
        
        
    }
}
