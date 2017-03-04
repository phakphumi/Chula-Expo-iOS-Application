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
        
        print(userType)
        print(name)
        print(email)
        print(age)
        print(gender)
        print(education)
        print(educationYear)
        print(school)
        print(career)
        print(fbId)
        print(fbToken)
        print(fbImageProfileUrl)
        print(fbImage)
        print(combinedTag)
        
        Alamofire.request("http://staff.chulaexpo.com/api/signup", method: .post, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
            
                let JSON = response.result.value as! NSDictionary
                let tokenResponse = JSON["results"] as! NSDictionary
            
                let header: HTTPHeaders = ["Authorization": "JWT \(tokenResponse["token"] as! String)"]
            
                Alamofire.request("http://staff.chulaexpo.com/api/me", headers: header).responseJSON { response in
                
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
        print("Selecr ", indexPath.row)
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
      //      print("\(cell.didSelectCell)")
            
        }
    }
    var facultyList: [tag] = []
    
    @IBAction func next(_ sender: Any) {
        var check = false
        facultyList.removeAll()
        for i in 0...tagList.count {
            print(selectedList[i])
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
            print(selectedList[i])
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
            
            self.performSegue(withIdentifier: "endEdit", sender: self)
            
        }
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "endEdit" {
            
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
            
            print(combinedTag)
                    
            let header: HTTPHeaders = ["Authorization": "JWT \(userToken!)"]
            
            Alamofire.request("http://staff.chulaexpo.com/api/me", method: .put, parameters: parameters, headers: header).responseJSON { response in
                
                if !response.result.isSuccess {
                    
                    let confirm = UIAlertController(title: "Error", message: "Can't connect to the server, please try again.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    confirm.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(confirm, animated: true, completion: nil)
                    
                    
                }
                
            }
            
        }
        
    }
    
}
