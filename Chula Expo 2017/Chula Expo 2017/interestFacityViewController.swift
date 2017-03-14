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
    var age: String?
    var gender: String?
    var education: String?
    var educationYear: String?
    var school: String?
    var career: String?
    var fbId: String?
    var fbToken: String?
    var fbImageProfileUrl: String?
    var fbImage: UIImage?
    var interested: String?
    var managedObjectContext: NSManagedObjectContext?
    
    var userToken: String?
    
    var tapped = [UIImageView]()
    
    var selectedList: [Bool] = []
    @IBOutlet var numberLabel: UILabel!
    
    var toEdit = false
    
    @IBOutlet weak var cancelEdit: UIButton!
    @IBOutlet weak var saveEdit: UIButton!
    
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
    struct facultyData {
        
        var imgName: String = ""
        var tagName: String = ""
        var tagBack: String = ""
        var tagEngName: String = ""
        var shortName: String = ""
        var zoneId: String = ""
        
    }

    @IBOutlet weak var collectionView: UICollectionView!
    var tagList : [facultyData] = [
        facultyData(imgName: "01_ENG",  tagName: "วิศวกรรมศาสตร์",  tagBack: "01-ENG-bg",  tagEngName: "Faculty of Engineering", shortName: "ENG", zoneId: "5899a98a5eeecd3698f6cfc6"),
        facultyData(imgName: "02_ARTS",  tagName: "อักษรศาสตร์",  tagBack: "02-ARTS-bg",  tagEngName: "Faculty of Arts", shortName: "ARTS", zoneId: "5899ac615eeecd3698f6cfd7"),
        facultyData(imgName: "03_SCI",  tagName: "วิทยาศาสตร์",  tagBack: "03-SCI-bg",  tagEngName: "Faculty of Science", shortName: "SCI", zoneId: "5899a9c75eeecd3698f6cfc8"),
        facultyData(imgName: "04_POLSCI",  tagName: "รัฐศาสตร์",  tagBack: "04-POLSCI-bg",  tagEngName: "Faculty of Political Science", shortName: "POLISC", zoneId: "5899aa3c5eeecd3698f6cfca"),
        facultyData(imgName: "05_",  tagName: "สถาปัตยกรรมศาสตร์",  tagBack: "05-ARCH-bg",  tagEngName: "Faculty of Architecture", shortName: "ARCH", zoneId: "5899abf85eeecd3698f6cfd4"),
        facultyData(imgName: "06_BANSHI",  tagName: "พาณิชยศาสตร์และการบัญชี",  tagBack: "06-BANSHI-bg",  tagEngName: "Faculty of Commerce and Accountancy", shortName: "BANSHI", zoneId: "5899aa015eeecd3698f6cfc9"),
        facultyData(imgName: "07_EDU",  tagName: "ครุศาสตร์",  tagBack: "07-EDU-bg",  tagEngName: "Faculty of Education", shortName: "EDU", zoneId: "5899aa7c5eeecd3698f6cfcc"),
        facultyData(imgName: "08_COMMARTS",  tagName: "นิเทศศาสตร์",  tagBack: "08-COMMARTS-bg",  tagEngName: "Faculty of Communication Arts", shortName: "COMMARTS", zoneId: "5899ab605eeecd3698f6cfd0"),
        facultyData(imgName: "09_ECON",  tagName: "เศรษฐศาสตร์",  tagBack: "09-ECON-bg",  tagEngName: "Faculty of Economic", shortName: "ECON", zoneId: "5899acb15eeecd3698f6cfd9"),
        facultyData(imgName: "10_MED",  tagName: "แพทยศาสตร์",  tagBack: "10-MED-bg",  tagEngName: "Faculty of Medicine", shortName: "MED", zoneId: "5899a9a85eeecd3698f6cfc7"),
        facultyData(imgName: "11_VET",  tagName: "สัตวแพทยศาสตร์",  tagBack: "11-VET-bg",  tagEngName: "Faculty of Veterinary Science", shortName: "VET", zoneId: "5899ac445eeecd3698f6cfd6"),
        facultyData(imgName: "12_DENT",  tagName: "ทันตแพทยศาสตร์",  tagBack: "12-DENT-bg",  tagEngName: "Faculty of Dentistry", shortName: "DENT", zoneId: "5899ab125eeecd3698f6cfce"),
        facultyData(imgName: "13_PHARM",  tagName: "เภสัชศาสตร์",  tagBack: "13-PHARM-bg",  tagEngName: "Faculty of Pharmaceutical Sciences", shortName: "PHARM", zoneId: "5899ac8d5eeecd3698f6cfd8"),
        facultyData(imgName: "14_LAW",  tagName: "นิติศาสตร์",  tagBack: "14-LAW-bg",  tagEngName: "Faculty of Law", shortName: "LAW", zoneId: "5899ab315eeecd3698f6cfcf"),
        facultyData(imgName: "15_FAA",  tagName: "ศิลปกรรมศาสตร์",  tagBack: "15-FAA-bg",  tagEngName: "Faculty of Fine and Applied Arts", shortName: "FAA", zoneId: "5899abd65eeecd3698f6cfd3"),
        facultyData(imgName: "16-NUR",  tagName: "พยาบาลศาสตร์",  tagBack: "16-FON-bg",  tagEngName: "Faculty of Nursing", shortName: "FON", zoneId: "5899ab815eeecd3698f6cfd1"),
        facultyData(imgName: "17_AHS",  tagName: "สหเวชศาสตร์",  tagBack: "17-AHS-bg",  tagEngName: "Faculty of Allied Health Sciences", shortName: "AHS", zoneId: "5899ac185eeecd3698f6cfd5"),
        facultyData(imgName: "18_PSY",  tagName: "จิตวิทยา",  tagBack: "18-PSY-bg",  tagEngName: "Faculty of Psychology", shortName: "PSY", zoneId: "5899aaf15eeecd3698f6cfcd"),
        facultyData(imgName: "19_SPSC",  tagName: "วิทยาศาสตร์การกีฬา",  tagBack: "19-SPSC-bg",  tagEngName: "Faculty of Sports Science", shortName: "SPSC", zoneId: "5899abae5eeecd3698f6cfd2"),
        facultyData(imgName: "20_SAR",  tagName: "สำนักวิชาทรัพยากรการเกษตร",  tagBack: "20-SAR-bg",  tagEngName: "School of Agricultural Resources", shortName: "SAR", zoneId: "5899acd95eeecd3698f6cfda"),
        facultyData(imgName: "21-TRCN",  tagName: "พยาบาลกาชาด",  tagBack: "21-TRCN-bg",  tagEngName: "Thai Red Cross College of Nursing", shortName: "TRCN", zoneId: "58c3dc0335603307a26ed634"),
        facultyData(imgName: "22-PNC",  tagName: "วิทยาลัยพยาบาลตำรวจ",  tagBack: "22-PNC-bg",  tagEngName: "Police Nursing College", shortName: "PNC", zoneId: "58bd7c2099b6e403ca3a6552"),
        facultyData(imgName: "23_GRAD",  tagName: "บัณฑิตวิทยาลัย",  tagBack: "23-GRAD-bg",  tagEngName: "Graduate School", shortName: "GRAD", zoneId: "5899acfe5eeecd3698f6cfdb"),
        facultyData(imgName: "24-RCU",  tagName: "หอพักนิสิต",  tagBack: "24-RCU-bg",  tagEngName: "Residence of Chulalongkorn University", shortName: "RCU", zoneId: "58c47c3f7b4c6d6cf35dbe2b")
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toEdit {
            
            finButton2.isHidden = true
            
            cancelEdit.isHidden = false
            saveEdit.isHidden = false
            
        }
        
        for _ in 0...tagList.count{
            selectedList.append(false)
        }
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: 10, left: 0.08*self.view.frame.width, bottom: 40, right: 0.08*self.view.frame.width)
         layout.itemSize = CGSize(width: 0.415*self.view.frame.width, height: 100)
         layout.minimumInteritemSpacing = 0.006*self.view.frame.width
         layout.minimumLineSpacing = 0.006*self.view.frame.width
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
        if let cell = cell as? interestCollectionViewCell1 {
            
            if tagList.count > (indexPath.row) {
                cell.imgName[0] = tagList[(indexPath.row)].imgName
                cell.tagName[0] = tagList[(indexPath.row)].tagName
                cell.tagBack[0] = tagList[(indexPath.row)].tagBack
                cell.tagEngName[0] = tagList[(indexPath.row)].tagEngName
                
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
                cell.tagName[0] = ""
            }
        }
        //cell.backgroundColor = UIColor.black
        return cell
    }
    
    private func registerToServer() {
        
        if self.gender == "ชาย" {
            
            self.gender = "Male"
            
        } else if self.gender == "หญิง" {
            
            self.gender = "Female"
            
        } else {
            
            self.gender = "Other"
            
        }
        
        if self.age == "-" {
            
            self.age = "0"
            
        }
        
        var faculties: String = ""
        
        for (index, faculty) in facultyList.enumerated() {
            
            if index == facultyList.endIndex - 1 {
                
                faculties += "\(faculty.tagEngName)"
                
            } else {
                
                faculties += "\(faculty.tagEngName),"
                
            }
            
        }
        
        let combinedTag = "\(interested!),\(faculties)"
        
        var parameters = [String: Any]()
        
        if self.userType == "Academic" {
            
            if let academicLevel = self.education,
                let academicYear = self.educationYear,
                let academicSchool = self.school,
                let gender = self.gender
            {
                
                if let facebook = self.fbId {
                    
                    parameters = [
                        "name": self.name,
                        "email": self.email,
                        "age": Int(self.age!) ?? 0,
                        "tags": combinedTag,
                        "academicLevel": academicLevel,
                        "academicYear": academicYear,
                        "academicSchool": academicSchool,
                        "gender": gender,
                        "type": self.userType,
                        "facebook": facebook,
                        "profile": self.fbImageProfileUrl!,
                        "tokens": [
                            [
                                "kind": "facebook",
                                "accessToken": self.fbToken!
                            ]
                            
                        ]
                    ]
                    
                }
            
            }
            
        } else {
            
            if let career = self.career,
                let gender = self.gender
            {
                
                if let facebook = self.fbId {
                    
                    parameters = [
                        "name": self.name,
                        "email": self.email,
                        "age": Int(self.age!) ?? 0,
                        "tags": combinedTag,
                        "workerJob": career,
                        "gender": gender,
                        "type": self.userType,
                        "facebook": facebook,
                        "profile": self.fbImageProfileUrl!,
                        "tokens": [
                            [
                                "kind": "facebook",
                                "accessToken": self.fbToken!
                            ]
                            
                        ]
                        
                    ]
                    
                }
                
            }

        }
        
        Alamofire.request("https://staff.chulaexpo.com/api/signup", method: .post, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
            
                let JSON = response.result.value as! NSDictionary
                let tokenResponse = JSON["results"] as! NSDictionary
            
                let header: HTTPHeaders = ["Authorization": "JWT \(tokenResponse["token"] as! String)"]
            
                Alamofire.request("https://staff.chulaexpo.com/api/me", headers: header).responseJSON { response in
                
                    if response.result.isSuccess {
                
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
                    
                        self.performSegue(withIdentifier: "toFinish", sender: self)
                    
                    } else {
                    
                        let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                    
                        confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                        self.present(confirm, animated: true, completion: nil)

                    
                    }
                
                }
                
            } else {
                
                let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                
                confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(confirm, animated: true, completion: nil)
                
            }
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedList[indexPath.row] == false {
            
            selectedList[indexPath.row] = true
        }
        else {
            
            selectedList[indexPath.row] = false
            
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? interestCollectionViewCell1{
            
            //cell.didSelectCell = selectedList[indexPath.row]
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
            
        }
        
    }
    var facultyList: [facultyData] = []
    
    @IBAction func next(_ sender: Any) {
        var check = false
        facultyList.removeAll()
        for i in 0...tagList.count {
            
            if selectedList[i] {
                facultyList.append(tagList[i])
                check = true
            }
        }
        
        
        if(check == false){
            let button2Alert: UIAlertView = UIAlertView(title: "", message: "please select", delegate: self, cancelButtonTitle: "OK")
            button2Alert.show()
        }
        else {
            
            registerToServer()
            
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
    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        var check = false
        facultyList.removeAll()
        for i in 0...tagList.count {
            
            if selectedList[i] {
                facultyList.append(tagList[i])
                check = true
            }
        }
        
        
        if(check == false){
            let button2Alert: UIAlertView = UIAlertView(title: "", message: "please select", delegate: self, cancelButtonTitle: "OK")
            button2Alert.show()
        }
        else {
            
            var faculties: String = ""
            
            for (index, faculty) in facultyList.enumerated() {
                
                if index == facultyList.endIndex - 1 {
                    
                    faculties += "\(faculty.tagEngName)"
                    
                } else {
                    
                    faculties += "\(faculty.tagEngName),"
                    
                }
                
            }
            
            let combinedTag = "\(interested!),\(faculties)"
            
            var parameters = [String: Any]()
            
            parameters = [
                "tags": combinedTag,
            ]
            
            let header: HTTPHeaders = ["Authorization": "JWT \(userToken!)"]
            
            Alamofire.request("https://staff.chulaexpo.com/api/me", method: .put, parameters: parameters, headers: header).responseJSON { response in
                
                if !response.result.isSuccess {
                    
                    let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(confirm, animated: true, completion: nil)
                    
                    
                }
                
                self.performSegue(withIdentifier: "endEdit", sender: self)
                
            }
            
        }
   
    }
    
    
}
