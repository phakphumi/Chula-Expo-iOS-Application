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
    
    var userToken: String?
    
    var selectedList: [Bool] = []
    var tapped = [UIImageView]()
    
    @IBOutlet var numberLabel: UILabel!
    
    var toEdit = false
        
    @IBOutlet weak var cancelEdit: UIButton!
    @IBOutlet weak var saveEdit: UIButton!
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
        tag(imgName: "1i",  tagName: "พลังงาน",  tagBack: "1",  tagEngName: "Energy"),
        tag(imgName: "2i",  tagName: "สังคมผู้สูงอายุ",  tagBack: "2",  tagEngName: "Ageing Society"),
        tag(imgName: "3i",  tagName: "ร่างกาย",  tagBack: "3",  tagEngName: "Body"),
        tag(imgName: "4i",  tagName: "จิตใจ",  tagBack: "4",  tagEngName: "Mind"),
        tag(imgName: "5i",  tagName: "ปัญหาสังคม",  tagBack: "5",  tagEngName: "Social Issues"),
        tag(imgName: "6i",  tagName: "สิ่งประดิษฐ์",  tagBack: "6",  tagEngName: "Invention"),
        tag(imgName: "7i",  tagName: "คุณภาพชีวิต",  tagBack: "7",  tagEngName: "Quality of Life"),
        tag(imgName: "8i",  tagName: "อาหารและการเกษตร",  tagBack: "8",  tagEngName: "Food & Agriculture"),
        tag(imgName: "9i",  tagName: "ชุมชน",  tagBack: "9",  tagEngName: "Community"),
        tag(imgName: "10i",  tagName: "ศิลปวัฒนธรรม",  tagBack: "10",  tagEngName: "Art & Culture"),
        tag(imgName: "11i",  tagName: "การแพทย์",  tagBack: "11",  tagEngName: "Medication"),
        tag(imgName: "12i",  tagName: "เศรษฐกิจ",  tagBack: "12",  tagEngName: "Economy"),
        tag(imgName: "13i",  tagName: "การขนส่ง",  tagBack: "13",  tagEngName: "Transportation"),
        tag(imgName: "14i",  tagName: "เทคโนโลยี",  tagBack: "14",  tagEngName: "Technology"),
        tag(imgName: "15i",  tagName: "สิ่งแวดล้อม",  tagBack: "15",  tagEngName: "Environment"),
        tag(imgName: "16i",  tagName: "ภูมิปัญญาไทย",  tagBack: "16",  tagEngName: "Thai Wisdom"),
        tag(imgName: "17i",  tagName: "การออกแบบ",  tagBack: "17",  tagEngName: "Design"),
        tag(imgName: "18i",  tagName: "กฎหมาย",  tagBack: "18",  tagEngName: "Law"),
        tag(imgName: "19i",  tagName: "การศึกษา",  tagBack: "19",  tagEngName: "Education"),
        tag(imgName: "20i",  tagName: "พระราชกรณียกิจ",  tagBack: "20",  tagEngName: "Royal Duties"),
        tag(imgName: "21i",  tagName: "ความงาม",  tagBack: "21",  tagEngName: "Beauty"),
        tag(imgName: "22i",  tagName: "สัตว์และพันธุ์พืช",  tagBack: "22",  tagEngName: "Life"),
        tag(imgName: "23i",  tagName: "การสื่อสาร",  tagBack: "23",  tagEngName: "Communication"),
        tag(imgName: "24i",  tagName: "กีฬา",  tagBack: "24",  tagEngName: "Sport"),
        tag(imgName: "25i",  tagName: "วิทยาศาสตร์",  tagBack: "25",  tagEngName: "Science"),
        tag(imgName: "26i",  tagName: "บันเทิง",  tagBack: "26",  tagEngName: "Entertainment"),
        tag(imgName: "27i",  tagName: "ต่างประเทศ",  tagBack: "27",  tagEngName: "International Issue")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toEdit {
            
            finButton.isHidden = true
            
            cancelEdit.isHidden = false
            saveEdit.isHidden = false
            
        }
        
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
//        var check = false
//        for i in 0...tagList.count {
//            // print(selectedList[i])
//            if selectedList[i] {
//                check = true
//            }
//        }
        
        if segue.identifier == "toFaculty" {
            
            var interested: String = ""
            
            for (index, interesting) in interestList.enumerated() {
                
                if index == interestList.endIndex - 1 {
                    
                    interested += "\(interesting.tagEngName)"
                    
                } else {
                    
                    interested += "\(interesting.tagEngName),"
                    
                }
                
            }

            let destination = segue.destination as! interestFacityViewController
            
            destination.userType = self.userType
            destination.name = self.name
            destination.email = self.email
            destination.age = self.age
            destination.gender = self.gender
            destination.fbId = self.fbId
            destination.fbToken = self.fbToken
            destination.fbImageProfileUrl = self.fbImageProfileUrl
            destination.fbImage = self.fbImage
            destination.interested = interested
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
            
        } else if segue.identifier == "editFaculty" {
            
            var interested: String = ""
            
            for (index, interesting) in interestList.enumerated() {
                
                if index == interestList.endIndex - 1 {
                    
                    interested += "\(interesting.tagEngName)"
                    
                } else {
                    
                    interested += "\(interesting.tagEngName),"
                    
                }
                
            }
            
            let destination = segue.destination as! interestFacityViewController
            
            destination.interested = interested
            destination.userToken = userToken
            destination.toEdit = toEdit
            
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
                cell.imgName = tagList[(indexPath.row)].imgName
                cell.tagName = tagList[(indexPath.row)].tagName
                cell.tagBack = tagList[(indexPath.row)].tagBack
                cell.tagEngName = tagList[(indexPath.row)].tagEngName
//                cell.didSelectCell = selectedList[indexPath.row]
                
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
                
            }else{
                cell.tagName = ""
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
            
//            cell.didSelectCell = selectedList[indexPath.row]
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
    var interestList: [tag] = []
    @IBAction func next(_ sender: UIButton) {
        var check = false
        interestList.removeAll()
        for i in 0...tagList.count {
           // print(selectedList[i])
            if selectedList[i] {
                interestList.append(tagList[i])
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
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        var check = false
        interestList.removeAll()
        for i in 0...tagList.count {
            // print(selectedList[i])
            if selectedList[i] {
                interestList.append(tagList[i])
                check = true
            }
        }
        
        if(check == false) {
            
            let button2Alert: UIAlertView = UIAlertView(title: "", message: "please select", delegate: self, cancelButtonTitle: "OK")
            
            button2Alert.show()
            
        } else {
            
            self.performSegue(withIdentifier: "editFaculty", sender: self)
            
        }
        
    }
}
