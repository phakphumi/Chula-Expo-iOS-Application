//
//  interestFacityViewController.swift
//  Chula Expo 2017
//
//  Created by Ekkalak Leelasornchai on 2/5/2560 BE.
//  Copyright © 2560 Chula Computer Engineering Batch#41. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class interestFacityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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
    
    var tapped = [UIImageView]()
    
    @IBOutlet var numberLabel: UILabel!
    
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
         layout.itemSize = CGSize(width: (self.view.frame.width-55)/2, height: 100)
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
    
    override func viewDidLayoutSubviews() {
        numberLabel.layer.cornerRadius = numberLabel.frame.height / 2
        
        
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
    
    @IBAction func registerToServer(_ sender: UIButton) {
        
        if self.gender == "ชาย" {
            
            self.gender = "Male"
            
        } else if self.gender == "หญิง" {
            
            self.gender = "Female"
            
        } else {
            
            self.gender = "Other"
            
        }
        
        var parameters = [String: Any]()
        
        if self.userType == "Academic" {
            
            parameters = [
                "name": self.name,
                "email": self.email,
                "age": Int(self.age) ?? 0,
                "academicLevel": self.education,
                "academicYear": self.educationYear,
                "academicSchool": self.school,
                "gender": self.gender,
                "type": self.userType,
                "facebook": self.fbId,
                "profile": self.fbImageProfileUrl ?? "",
                "tokens": [
                    [
                            "kind": "facebook",
                            "accessToken": self.fbToken
                    ]
                    
                ]
            ]
            
        } else {
            
            parameters = [
                "name": self.name,
                "email": self.email,
                "age": Int(self.age) ?? 0,
                "workerJob": self.career,
                "gender": self.gender,
                "type": self.userType,
                "facebook": self.fbId,
                "profile": self.fbImageProfileUrl ?? "",
                "tokens": [
                    [
                        "kind": "facebook",
                        "accessToken": self.fbToken
                    ]
                    
                ]
            ]
            
        }
        
        Alamofire.request("http://staff.chulaexpo.com/api/signup", method: .post, parameters: parameters).responseJSON { (response) in
            
            let JSON = response.result.value as! NSDictionary
            let tokenResponse = JSON["results"] as! NSDictionary
            print(parameters)
            print(JSON)
            
            let header: HTTPHeaders = ["Authorization": "JWT \(tokenResponse["token"] as! String)"]
            
            Alamofire.request("http://staff.chulaexpo.com/api/me", headers: header).responseJSON { response in
                
                let JSON = response.result.value as! NSDictionary
                
                if let results = JSON["results"] as? NSDictionary{
                    
                    let academic = results["academic"] as? [String: String]
                    
                    let worker = results["worker"] as? [String: String]
                    
                    let managedObjectContext: NSManagedObjectContext? =
                        (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
                    
                    managedObjectContext?.performAndWait {
                        
                        _ = UserData.addUser(id: results["_id"] as! String,
                                             token: tokenResponse["token"] as! String,
                                             type: results["type"] as! String,
                                             name: results["name"] as! String,
                                             email: results["email"] as! String,
                                             age: results["age"] as! Int,
                                             gender: results["gender"] as! String,
                                             school: academic?["school"] ?? "",
                                             level: academic?["level"] ?? "",
                                             year: academic?["year"] ?? "",
                                             job: worker?["job"] ?? "",
                                             profile: results["profile"] as? String ?? "",
                                             inManageobjectcontext: managedObjectContext!
                        )
                        
                    }
                    
                    do {
                        
                        try managedObjectContext?.save()
                        print("saved user")
                        
                    } catch let error {
                        
                        print("saveUserError with \(error)")
                        
                    }
                    
                }
                
            }
            
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
    
}
